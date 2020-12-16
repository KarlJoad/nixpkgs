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
, python27
, python27Packages
, python3
, python38Packages
, gnuplot
, texinfo
}:

let

  isOctaveFull = octave.enableQt;
  isOctaveJIT = octave.enableJIT;

  callPackage = pkgs.newScope {
    inherit (pkgs) lib;
    inherit pkgs fetchurl stdenv;
    inherit octave gnuplot texinfo;
  };

in rec {

  control = callPackage ../development/octave-modules/control {
    gfortran = gfortran;
    autoreconfHook = autoreconfHook;
    lapack = lapack;
    blas = blas;
  };

  linearAlgebra = callPackage ../development/octave-modules/linear-algebra { };

  signal = callPackage ../development/octave-modules/signal {
    stdenv = stdenv;
    python = python3;
    control = control;
  };

  symbolic = callPackage ../development/octave-modules/symbolic {
    python3 = python3;
    sympy = python27Packages.sympy;
    mpmath = python38Packages.mpmath;
  };

}
