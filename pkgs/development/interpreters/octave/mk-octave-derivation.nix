# Generic builder for GNU Octave libraries.
# This is a file that contains nested functions. The first, outer, function
# is the library- and package-wide details, such as the nixpkgs library, any
# additional configuration provided, and the namePrefix to use (based on the
# pname and version of Octave), the octave package, etc.

{ pkgs
, lib
, stdenv
, config
, namePrefix
, octave
}:

# The inner function contains information required to build the individual
# libraries.
{ fullLibName ? "${attrs.pname}-${attrs.version}"

, src

# Build-time dependencies for the package
, nativeBuildInputs ? []

# Run-time dependencies for the package
, buildInputs ? []

# Propagate build dependencies so in case we have A -> B -> C,
# C can import package A propagated by B
, propagatedBuildInputs ? []

, meta ? {}

, passthru ? {}

, ... } @ attrs:

let
  self = stdenv.mkDerivation {
    packageName = "${fullLibName}";
    name = "${namePrefix}-${fullLibName}";
    src = src;

    OCTAVE_HISTFILE = "/dev/null";

    dontUnpack = true;

    nativeBuildInputs = [
      octave
    ]
    ++ nativeBuildInputs;

    buildInputs = buildInputs;

    propagatedBuildInputs = propagatedBuildInputs;

    buildPhase = ''
      mkdir -p $out
      octave-cli --eval "pkg build $out $src"
    '';

    # We don't install here, because that's handled when we build the environment
    # together with Octave.
    dontInstall = true;

    meta = meta;
  };
in lib.extendDerivation true passthru self
# Always extend the derivation, passthru is extras, self is derivation to eval
# https://github.com/NixOS/nixpkgs/blob/66acfa3d16eb599f5aa85bda153a24742f683383/lib/customisation.nix#L144
