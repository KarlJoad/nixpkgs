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
let
  env = let
    paths = extraLibs ++ [ octave ];
    octavePath = "${octave}";
    octaveExecutable = "${placeholder "out"}/bin/octave-cli";
  in (buildEnv {
    name = "${octave.name}-env";

    inherit paths;
    inherit ignoreCollisions;
    extraOutputsToInstall = [ "out" ] ++ extraOutputsToInstall;

    # During "build" we must first unlink the /share symlink to octave's /share
    # Then, we can re-symlink the all of octave/share, except for /share/octave
    # in env/share/octave, re-symlink everything from octave/share/octave and then
    # perform the pkg install.
    postBuild = ''
      if [ -L "$out/bin" ]; then
         unlink $out/bin
         mkdir -p "$out/bin"
         cd "${octavePath}/bin"
         for prg in *; do
             if [ -x $prg ]; then
                makeWrapper "${octavePath}/bin/$prg" "$out/bin/$prg" --set OCTAVE_SITE_INITFILE "$out/share/octave/site/m/startup/octaverc"
             fi
         done
         cd $out
      fi

      # Remove symlinks to the input tarballs, they aren't needed.
      for tarball in $out/*.tar.gz; do
          unlink $tarball
      done

      if [ -L "$out/share" ]; then
          unlink "$out/share"
          mkdir -p "$out/share"
      fi

      for f in ${octavePath}/share/*; do
          ln -s -t $out/share $f
      done

      if [ -L "$out/share/octave" ]; then
         unlink "$out/share/octave"
         mkdir -p $out/share/octave
         for f in ${octavePath}/share/octave/*; do
             ln -s -t $out/share/octave $f
         done
      fi

      mkdir -p $out/share/octave/octave_packages
      for path in ${stdenv.lib.concatStringsSep " " extraLibs}; do
          if [ -e $path/*.tar.gz ]; then
             ${octaveExecutable} --eval "pkg local_list $out/.octave_packages; \
                                         pkg prefix $out/${octave.octPkgsPath} $out/${octave.octPkgsPath}; \
                                         pfx = pkg (\"prefix\"); \
                                         pkg install -nodeps -local $path/*.tar.gz"
          fi
      done

      # Re-write the octave-wide startup file (share/octave/site/m/startup/octaverc)
      # To point to the new local_list in $out
      ls -l $out/share/octave
      echo "$out/share/octave/site"
      echo "${octavePath}/share/octave/site"
      unlinkDirReSymlinkContents "$out/share/octave/site" "${octavePath}/share/octave/site"
      # unlink $out/share/octave/site
      # mkdir -p $out/share/octave/site
      # for f in ${octavePath}/share/octave/site/*; do
      #     ln -s -t $out/share/octave/site $f
      # done
      ls -l $out/share/octave/site

      unlink $out/share/octave/site/m
      mkdir -p $out/share/octave/site/m
      for f in ${octavePath}/share/octave/site/m/*; do
          ln -s -t $out/share/octave/site/m $f
      done

      unlink $out/share/octave/site/m/startup
      mkdir -p $out/share/octave/site/m/startup
      for f in ${octavePath}/share/octave/site/m/startup/*; do
          ln -s -t $out/share/octave/site/m/startup $f
      done

      unlink $out/share/octave/site/m/startup/octaverc
      cp ${octavePath}/share/octave/site/m/startup/octaverc $out/share/octave/site/m/startup/octaverc
      chmod u+w $out/share/octave/site/m/startup/octaverc
      echo "pkg local_list $out/.octave_packages" >> $out/share/octave/site/m/startup/octaverc
     '' + postBuild;

    inherit (octave) meta;

    passthru = octave.passthru // {
      interpreter = "${env}/bin/octave";
      inherit octave;
      env = stdenv.mkDerivation {
        name = "interactive-${octave.name}-environment";
        nativeBuildInputs = [ env ];

        buildCommand = ''
        echo >&2 ""
        echo >&2 "*** octave 'env' attributes are intended for interactive nix-shell sessions, not for building! ***"
        echo >&2 ""
        exit 1
      '';
      };
    };
  }).overrideAttrs (_: {
    # Add extra package dependencies needed for postBuild hook.
    nativeBuildInputs = [ makeWrapper texinfo wrapOctave ];
  });
in env
