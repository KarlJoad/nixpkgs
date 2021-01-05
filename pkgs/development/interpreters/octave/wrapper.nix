{ stdenv, octave, buildEnv
, makeWrapper, texinfo
, octavePackages
, wrapOctave
, extraLibs ? []
, extraOutputsToInstall ? []
, postBuild ? ""
, ignoreCollisions ? false
}:

# Create an octave executable that knows about additional packages
buildEnv {
    name = "${octave.name}-env";
    paths = extraLibs ++ [ octave ];

    inherit ignoreCollisions;
    extraOutputsToInstall = [ "out" ] ++ extraOutputsToInstall;

    buildInputs = [ makeWrapper texinfo ];

    # During "build" we must first unlink the /share symlink to octave's /share
    # Then, we can re-symlink the all of octave/share, except for /share/octave
    # in env/share/octave, re-symlink everything from octave/share/octave and then
    # perform the pkg install.
    postBuild = ''
      if [ -L "$out/bin" ]; then
         unlink $out/bin
         mkdir -p "$out/bin"
         cd "${octave}/bin"
         for prg in *; do
             if [ -x $prg ]; then
                makeWrapper "${octave}/bin/$prg" "$out/bin/$prg" --set OCTAVE_SITE_INITFILE "$out/share/octave/site/m/startup/octaverc"
             fi
         done
         cd $out
      fi

      # Remove symlinks to the input tarballs, they aren't needed.
      rm $out/*.tar.gz

      if [ -L "$out/share" ]; then
          unlink "$out/share"
          mkdir -p "$out/share"
      fi

      for f in ${octave}/share/*; do
          ln -s -t $out/share $f
      done

      if [ -L "$out/share/octave" ]; then
         unlink "$out/share/octave"
         mkdir -p $out/share/octave
         for f in ${octave}/share/octave/*; do
             ln -s -t $out/share/octave $f
         done
      fi

      mkdir -p $out/share/octave/octave_packages
      for path in ${stdenv.lib.concatStringsSep " " extraLibs}; do
          if [ -e $path/*.tar.gz ]; then
             $out/bin/octave-cli --eval "pkg local_list $out/.octave_packages; \
                                         pkg prefix $out/${octave.octPkgsPath} $out/${octave.octPkgsPath}; \
                                         pfx = pkg (\"prefix\"); \
                                         pkg install -nodeps -local $path/*.tar.gz"
          fi
      done

      # Re-write the octave-wide startup file (share/octave/site/m/startup/octaverc)
      # To point to the new local_list in $out
      unlinkDirReSymlinkContents $out/share/octave/site ${octavePath}/share/octave/site
      # unlink $out/share/octave/site
      # mkdir -p $out/share/octave/site
      # for f in ${octavePath}/share/octave/site/*; do
      #     ln -s -t $out/share/octave/site $f
      # done

      unlink $out/share/octave/site/m
      mkdir -p $out/share/octave/site/m
      for f in ${octave}/share/octave/site/m/*; do
          ln -s -t $out/share/octave/site/m $f
      done

      unlink $out/share/octave/site/m/startup
      mkdir -p $out/share/octave/site/m/startup
      for f in ${octave}/share/octave/site/m/startup/*; do
          ln -s -t $out/share/octave/site/m/startup $f
      done

      unlink $out/share/octave/site/m/startup/octaverc
      cp ${octave}/share/octave/site/m/startup/octaverc $out/share/octave/site/m/startup/octaverc
      chmod u+w $out/share/octave/site/m/startup/octaverc
      echo "pkg local_list $out/.octave_packages" >> $out/share/octave/site/m/startup/octaverc
     '' + postBuild;

    inherit (octave) meta;

    passthru = octave.passthru // {
      interpreter = "$out/bin/octave";
      inherit octave;
      env = stdenv.mkDerivation {
        name = "interactive-${octave.name}-environment";

        buildCommand = ''
        echo >&2 ""
        echo >&2 "*** octave 'env' attributes are intended for interactive nix-shell sessions, not for building! ***"
        echo >&2 ""
        exit 1
      '';
      };
    };
}
