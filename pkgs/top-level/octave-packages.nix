# This file contains the GNU Octave add-on packages set.
# Each attribute is an Octave library.
# Expressions for the Octave libraries are supposed to be in `pkgs/development/octave-modules/<name>/default.nix`.

{ pkgs
, lib
, stdenv
, fetchTarball
, newScope
, octave
, lapack, blas, flibs
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
    inherit pkgs fetchTarball octave;
  };

  sympy = pkgs.pythonPackages.sympy;
  mpmath = pkgs.pythonPackages.mpmath;

in rec {

  control = callPackage ../development/octave-modules/control {
    gfortran = gfortran;
    autoreconfHook = autoreconfHook;
    lapack = lapack;
    blas = blas;
    flibs = flibs;
  };

  linearAlgebra = callPackage ../development/octave-modules/linear-algebra { };

  signal = callPackage ../development/octave-modules/signal {
    stdenv = stdenv;
    python = python;
    control = control;
  };

  symbolic = callPackage ../development/octave-modules/symbolic {
    python = python;
    sympy = pythonPackages.sympy;
    mpmath = pythonPackages.mpmath;
  };

}
