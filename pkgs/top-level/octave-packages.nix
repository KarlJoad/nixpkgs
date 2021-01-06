# This file contains the GNU Octave add-on packages set.
# Each attribute is an Octave library.
# Expressions for the Octave libraries are supposed to be in `pkgs/development/octave-modules/<name>/default.nix`.

{ pkgs
, lib
, stdenv
, fetchurl
, newScope
, octave
, lapack, blas
, gfortran
, autoreconfHook
, python3
, python3Packages
, jdk
, gnuplot
, texinfo
, nettle
}:

let

  isOctaveFull = octave.enableQt;
  isOctaveJIT = octave.enableJIT;

  buildOctaveLibrary = callPackage ../development/interpreters/octave/mk-octave-derivation.nix {
    inherit pkgs lib stdenv;
    namePrefix = "${octave.pname}-${octave.version}";
    inherit octave;
  };

  callPackage = pkgs.newScope {
    inherit (pkgs) lib stdenv;
    inherit buildOctaveLibrary;
    inherit fetchurl;
    inherit gnuplot texinfo;
  };

in rec {

  control = callPackage ../development/octave-modules/control {
    gfortran = gfortran;
    autoreconfHook = autoreconfHook;
    lapack = lapack;
    blas = blas;
  };

  io = callPackage ../development/octave-modules/io {
    enableJava = true;
    jdk = jdk;
  };

  general = callPackage ../development/octave-modules/general {
    nettle = nettle;
  linear-algebra = callPackage ../development/octave-modules/linear-algebra { };
  ltfat = callPackage ../development/octave-modules/ltfat {
    fftw = pkgs.fftw;
    fftwSinglePrec = pkgs.fftwSinglePrec;
    fftwFloat = pkgs.fftwFloat;
    fftwLongDouble = pkgs.fftwLongDouble;
    lapack = lapack;
    blas = blas;
    portaudio = pkgs.portaudio;
    jre = pkgs.jre;
  };


  signal = callPackage ../development/octave-modules/signal {
    control = control;
  };

  symbolic = callPackage ../development/octave-modules/symbolic {
    # Need to use sympy 1.5.1 for https://github.com/cbm755/octsympy/issues/1023
    # It has been addressed, but not merged yet.
    pythonEnv = (let
      overridenPython = let
        packageOverrides = self: super: {
          sympy = super.sympy.overridePythonAttrs (old: rec {
            version = pkgs.python2Packages.sympy.version;
            src = pkgs.python2Packages.sympy.src;
          });
        };
      in python3.override {inherit packageOverrides; self = overridenPython; };
    in overridenPython.withPackages (ps: [
      ps.sympy
      ps.mpmath
    ]));
  };

}
