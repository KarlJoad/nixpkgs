{ stdenv, octave, buildEnv
, octavePackages
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
  in buildEnv {
    name = "${octave.name}-env";

    inherit paths;
    inherit ignoreCollisions;
    extraOutputsToInstall = [ "out" ] ++ extraOutputsToInstall;

    # During "build" we must first unlink the /share symlink to octave's /share
    # Then, we can re-symlink the all of octave/share, except for /share/octave
    # in env/share/octave, re-symlink everything from octave/share/octave and then
    # perform the pkg install.
    postBuild = ''
      echo "Unlinking $out/share"
      if [ -L "$out/share" ]; then
          unlink "$out/share"
      fi
      echo "Making $out/share directory"
      mkdir -p "$out/share"
      unlink $out/*.tar.gz

      echo "Octave's Share is at: ${octavePath}/share"
      echo "Re-symlinking contents of ${octavePath}/share"
      for f in ${octavePath}/share/*; do
          echo "ln -s $f"
          ln -s -t $out/share $f
      done
      echo "Unlinking $out/share/octave and re-symlinking with contents of ${octavePath}/share/octave"
      if [ -L "$out/share/octave" ]; then
         unlink "$out/share/octave"
         mkdir -p $out/share/octave
         echo "Unlinked!"
         for f in ${octavePath}/share/octave/*; do
             echo "ln -s $f"
             ln -s -t $out/share/octave $f
         done
      fi

      for path in ${stdenv.lib.concatStringsSep " " extraLibs}; do
          if [ -e $path/*.tar.gz ]; then
             echo $path
             echo "${octaveExecutable} --eval 'pkg local_list $out/.octave_packages; pkg prefix $out/${octave.octPkgsPath}; pfx = pkg (\"prefix\"); pfx'"
             echo "${octaveExecutable} --eval 'pkg install -nodeps -local $path/*.tar.gz'"
             ${octaveExecutable} --eval "pkg local_list $out/.octave_packages; pkg prefix $out/${octave.octPkgsPath}; pfx = pkg (\"prefix\"); pfx; pkg install -nodeps -local $path/*.tar.gz"
          fi
      done
    '' + postBuild;
  };

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
in env
