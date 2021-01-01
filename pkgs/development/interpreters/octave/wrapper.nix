{ stdenv, octave, buildEnv
, octavePackages
, extraLibs ? []
, extraOutputsToInstall ? []
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
  };
in env
