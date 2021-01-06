# This file contains the GNU Octave add-on packages set.
# Each attribute is an Octave library.
# Expressions for the Octave libraries are supposed to be in `pkgs/development/octave-modules/<name>/default.nix`.

{ pkgs
, lib
, stdenv
, fetchurl
, newScope
, octave
}:

with lib;

makeScope newScope (self:
  let
    inherit (octave) blas lapack gfortran python texinfo gnuplot;

    callPackage = self.callPackage;

    buildOctaveLibrary = callPackage ../development/interpreters/octave/mk-octave-derivation.nix {
      inherit pkgs lib stdenv;
      namePrefix = "${octave.pname}-${octave.version}";
      inherit octave;
    };

  in {

    inherit callPackage buildOctaveLibrary;

    arduino = callPackage ../development/octave-modules/arduino {
      arduino = pkgs.arduino;
      # Full arduino right now. Might be able to use pkgs.arduino-core
      # Needs arduinoIDE as a runtime dependency.
    };

    audio = callPackage ../development/octave-modules/audio {
      rtmidi = pkgs.rtmidi;
    };

    bim = callPackage ../development/octave-modules/bim { };

    bsltl = callPackage ../development/octave-modules/bsltl { };

    cgi = callPackage ../development/octave-modules/cgi { };

    communications = callPackage ../development/octave-modules/communications { };

    control = callPackage ../development/octave-modules/control { };

    data-smoothing = callPackage ../development/octave-modules/data-smoothing { };

    database = callPackage ../development/octave-modules/database {
      postgresql = pkgs.postgresql;
    };

    dataframe = callPackage ../development/octave-modules/dataframe { };

    general = callPackage ../development/octave-modules/general {
      nettle = pkgs.nettle;
    };

    io = callPackage ../development/octave-modules/io {
      unzip = pkgs.unzip;
    };

    level-set = callPackage ../development/octave-modules/level-set { };

    linear-algebra = callPackage ../development/octave-modules/linear-algebra { };

    ltfat = callPackage ../development/octave-modules/ltfat {
      fftw = octave.fftw;
      fftwSinglePrec = octave.fftwSinglePrec;
      fftwFloat = pkgs.fftwFloat;
      fftwLongDouble = pkgs.fftwLongDouble;
      portaudio = octave.portaudio;
      jre = octave.jdk;
    };

    signal = callPackage ../development/octave-modules/signal { };

    symbolic = callPackage ../development/octave-modules/symbolic {
      # Need to use sympy 1.5.1 for https://github.com/cbm755/octsympy/issues/1023
      # It has been addressed, but not merged yet.
      python2Packages = pkgs.python2Packages;
    };

  })
