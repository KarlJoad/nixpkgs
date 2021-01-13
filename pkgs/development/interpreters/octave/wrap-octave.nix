{ lib
, octave
, makeSetupHook
, makeWrapper
}:

with lib;

# Defined in trivial-builders.nix
# Imported as wrapOctave in octave/default.nix and passed to octave's buildEnv
# as nativeBuildInput
# Each of the substitutions is available in the wrap.sh script as @thingSubstituted@
makeSetupHook {
  deps = makeWrapper;
  substitutions.executable = octave.interpreter;
  substitutions.octave = octave;
} ./wrap.sh
