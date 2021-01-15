# Generic builder for GNU Octave libraries.
# This is a file that contains nested functions. The first, outer, function
# is the library- and package-wide details, such as the nixpkgs library, any
# additional configuration provided, and the namePrefix to use (based on the
# pname and version of Octave), the octave package, etc.

{ lib
, stdenv
, config
, octave
, texinfo
, computeRequiredOctavePackages
, octaveWriteRequiredOctavePackagesHook
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

# Octave packages that are required at runtime for this one.
# These behave similarly to propagatedBuildInputs, where if
# package A is needed by B, and C needs B, then C also requires A.
# The main difference between these and propagatedBuildInputs is
# during the package's installation into octave, where all
# requiredOctavePackages are ALSO installed into octave.
, requiredOctavePackages ? []

, meta ? {}

, passthru ? {}

, ... } @ attrs:

let
  requiredOctavePackages' = computeRequiredOctavePackages requiredOctavePackages;

  self = stdenv.mkDerivation {
    packageName = "${fullLibName}";
    # The name of the octave package ends up being
    # "octave-version-package-version"
    name = "${octave.pname}-${octave.version}-${fullLibName}";
    inherit src;

    OCTAVE_HISTFILE = "/dev/null";

    # This states that any package built with the function that this returns
    # will be an octave package. This is used for ensuring other octave
    # packages are installed into octave during the environment building phase.
    isOctavePackage = true;

    dontUnpack = true;

    requiredOctavePackages = requiredOctavePackages';

    nativeBuildInputs = [
      octave
      octaveWriteRequiredOctavePackagesHook
    ]
    ++ nativeBuildInputs;

    buildInputs = buildInputs ++ requiredOctavePackages';

    propagatedBuildInputs = propagatedBuildInputs ++ [ texinfo ];

    buildPhase = ''
      runHook preBuild

      mkdir -p $out
      octave-cli --eval "pkg build $out $src"

      runHook postBuild
    '';

    # We don't install here, because that's handled when we build the environment
    # together with Octave.
    dontInstall = true;

    meta = meta;
  };
in lib.extendDerivation true passthru self
# Always extend the derivation, passthru is extras, self is derivation to eval
# https://github.com/NixOS/nixpkgs/blob/66acfa3d16eb599f5aa85bda153a24742f683383/lib/customisation.nix#L144
