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
# Octave libraries have 3 directories of major interest. 1) The root of the
# library. 2) The src directory where source files (for compilation) are. 3) The
# inst directory, which has *.m function files, which plug into Octave directly.
, root ? fullLibName
, srcRoot ? "${fullLibName}/src"
, instRoot ? "${fullLibName}/inst"

, doAutoReconf ? false
, autoreconfHook ? null

# Build-time dependencies for the package
, nativeBuildInputs ? []

# Run-time dependencies for the package
, buildInputs ? []

# Some packages don't have anything to compile.
, dontBuild ? false
# If we want to go through buildPhase, but take no actions
, emptyBuild ? false

# Propagate build dependencies so in case we have A -> B -> C,
# C can import package A propagated by B
, propagatedBuildInputs ? []

, doCheck ? false
# Dependencies needed for running the checkPhase.
# These are added to buildInputs when doCheck = true.
, checkInputs ? []
, preCheck ? ""
, postCheck ? ""

, postInstall ? ""

, meta ? {}

, passthru ? {}

, ... } @ attrs:

let
  self = stdenv.mkDerivation {
    name = "${namePrefix}-${fullLibName}";
    src = src;

    OCTAVE_HISTFILE = "/dev/null";

    sourceRoot = srcRoot;

    dontBuild = dontBuild;
    nativeBuildInputs = [
      octave
    ]
    ++ (stdenv.lib.optional doAutoReconf pkgs.autoreconfHook)
    ++ nativeBuildInputs;

    buildInputs = buildInputs;

    propagatedBuildInputs = propagatedBuildInputs;

    # Some Octave libraries have easy-to-test libraries, but some don't have
    # any such testing capabilities either. Default to false, but allow it as
    # the end-user likes.
    doCheck = doCheck;
    checkInputs = checkInputs;
    preCheck = preCheck;
    postCheck = postCheck;

    # In the install phase, if we compiled anything in the buildPhase, then we
    # must copy the resulting binaries out. If not, then we skip that and move
    # onto copying the scripts out.
    installPhase = let
      copyCompiledBinaries =
        if dontBuild || emptyBuild then
          ""
        else
          ''
            cp *.oct $out/
            # Currently in $sourceRoot. End up in root of unpack.
            cd ..
          '';
    in ''
         mkdir -p $out
       '' + copyCompiledBinaries + ''
         # Copy all the Octave files, with the package's functions, out.
            cp -r inst/* $out/
       '';

    postInstall = postInstall + ''
      # Copy the distribution information.
      mkdir -p $out/packinfo
      cp COPYING DESCRIPTION INDEX NEWS $out/packinfo/
    '';

    meta = meta;
  };
in lib.extendDerivation true passthru self
# Always extend the derivation, passthru is extras, self is derivation to eval
# https://github.com/NixOS/nixpkgs/blob/66acfa3d16eb599f5aa85bda153a24742f683383/lib/customisation.nix#L144
