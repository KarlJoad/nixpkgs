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
# Use the same python that octave is using
, python
# Use the same Java that octave is using
, enableJava
, jdk
, gnuplot
, texinfo
, nettle
}:

with lib;

makeScope newScope (self:
  let
    callPackage = self.callPackage;

    buildOctaveLibrary = callPackage ../development/interpreters/octave/mk-octave-derivation.nix {
      inherit pkgs lib stdenv;
      namePrefix = "${octave.pname}-${octave.version}";
      inherit octave;
    };

  in {

    inherit callPackage buildOctaveLibrary;

    control = callPackage ../development/octave-modules/control { };

    io = callPackage ../development/octave-modules/io {
      unzip = pkgs.unzip;
    };

    level-set = callPackage ../development/octave-modules/level-set { };

    linear-algebra = callPackage ../development/octave-modules/linear-algebra { };

    ltfat = callPackage ../development/octave-modules/ltfat {
      fftw = pkgs.fftw;
      fftwSinglePrec = pkgs.fftwSinglePrec;
      fftwFloat = pkgs.fftwFloat;
      fftwLongDouble = pkgs.fftwLongDouble;
      portaudio = pkgs.portaudio;
      jre = pkgs.jre;
    };

    signal = callPackage ../development/octave-modules/signal { };

    symbolic = callPackage ../development/octave-modules/symbolic {
      # Need to use sympy 1.5.1 for https://github.com/cbm755/octsympy/issues/1023
      # It has been addressed, but not merged yet.
      python2Packages = pkgs.python2Packages;
    };

  })
