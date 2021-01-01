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

, postInstall ? ""

, meta ? {}

, passthru ? {}

, ... } @ attrs:

let
  self = stdenv.mkDerivation {
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
    buildPhase = ''
      mkdir -p $out
      octave-cli --eval "pkg build $out $src"
    '';

    meta = meta;
  };
in lib.extendDerivation true passthru self
# Always extend the derivation, passthru is extras, self is derivation to eval
# https://github.com/NixOS/nixpkgs/blob/66acfa3d16eb599f5aa85bda153a24742f683383/lib/customisation.nix#L144
