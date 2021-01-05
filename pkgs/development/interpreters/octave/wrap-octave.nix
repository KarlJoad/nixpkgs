{ lib
, octave
, makeSetupHook
, makeWrapper
}:

with lib;

# Defined in trivial-builders.nix
# Imported as wrapOctave in octave/default.nix and passed to octave's buildEnv as nativeBuildInput
makeSetupHook {
  deps = makeWrapper;
} ./wrap.sh
