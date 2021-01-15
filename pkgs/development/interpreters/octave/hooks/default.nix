# Hooks for building Octave packages.
{ octave
, lib
, callPackage
, makeSetupHook
}:

rec {
  octaveWriteRequiredOctavePackagesHook = callPackage ({ }:
    makeSetupHook {
      name = "octave-write-required-octave-packages-hook";
    } ./octave-write-required-octave-packages-hook.sh) {};
}
