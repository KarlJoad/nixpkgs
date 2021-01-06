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

    dicom = callPackage ../development/octave-modules/dicom {
      libgdcm = pkgs.gdcm;
    };

    divand = callPackage ../development/octave-modules/divand { };

    doctest = callPackage ../development/octave-modules/doctest { };

    econometrics = callPackage ../development/octave-modules/econometrics { };

    fem-fenics = callPackage ../development/octave-modules/fem-fenics {
      # I am still not super sure about this
      dolfin = python.pkgs.fenics;
      fenics = python.pkgs.fenics;
      pkg-config = pkgs.pkg-config;
    };

    fits = callPackage ../development/octave-modules/fits {
      cfitsio = pkgs.cfitsio;
    };

    financial = callPackage ../development/octave-modules/financial { };

    fpl = callPackage ../development/octave-modules/fpl { };

    fuzzy-logic-toolkit = callPackage ../development/octave-modules/fuzzy-logic-toolkit { };

    ga = callPackage ../development/octave-modules/ga { };

    general = callPackage ../development/octave-modules/general {
      nettle = pkgs.nettle;
    };

    generate_html = callPackage ../development/octave-modules/generate_html { };

    geometry = callPackage ../development/octave-modules/geometry { };

    gsl = callPackage ../development/octave-modules/gsl {
      gslPackage = pkgs.gsl;
    };

    image = callPackage ../development/octave-modules/image { };

    image-acquisition = callPackage ../development/octave-modules/image-acquisition {
      libv4l = pkgs.libv4l;
      libfltk = pkgs.fltk;
    };

    instrument-control = callPackage ../development/octave-modules/instrument-control { };

    io = callPackage ../development/octave-modules/io {
      unzip = pkgs.unzip;
    };

    interval = callPackage ../development/octave-modules/interval {
      mpfr = pkgs.mpfr;
      libmpfr = pkgs.mpfr;
    };

    level-set = callPackage ../development/octave-modules/level-set { };

    linear-algebra = callPackage ../development/octave-modules/linear-algebra { };

    lssa = callPackage ../development/octave-modules/lssa { };

    ltfat = callPackage ../development/octave-modules/ltfat {
      fftw = octave.fftw;
      fftwSinglePrec = octave.fftwSinglePrec;
      fftwFloat = pkgs.fftwFloat;
      fftwLongDouble = pkgs.fftwLongDouble;
      portaudio = octave.portaudio;
      jre = octave.jdk;
    };

    mapping = callPackage ../development/octave-modules/mapping { };

    matgeom = callPackage ../development/octave-modules/matgeom { };

    miscellaneous = callPackage ../development/octave-modules/miscellaneous {
      termcap = pkgs.mlterm;
      libncurses = pkgs.ncurses;
      units = pkgs.units;
    };

    msh = callPackage ../development/octave-modules/msh {
      gmsh = pkgs.gmsh;
      awk = pkgs.awk;
      dolfin = python.pkgs.fenics;
    };

    mvn = callPackage ../development/octave-modules/mvn { };

    nan = callPackage ../development/octave-modules/nan { };

    ncarray = callPackage ../development/octave-modules/ncarray { };

    netcdf = callPackage ../development/octave-modules/netcdf {
      netcdfPackage = pkgs.netcdf;
    };

    nurbs = callPackage ../development/octave-modules/nurbs { };

    ocl = callPackage ../development/octave-modules/ocl { };

    octclip = callPackage ../development/octave-modules/octclip { };

    octproj = callPackage ../development/octave-modules/octproj {
      proj = pkgs.proj;
    };

    optics = callPackage ../development/octave-modules/optics { };

    optim = callPackage ../development/octave-modules/optim { };

    optiminterp = callPackage ../development/octave-modules/optiminterp { };

    parallel = callPackage ../development/octave-modules/parallel {
      gnutls = pkgs.gnutls;
      pkg-config = pkgs.pkg-config;
    };

    quaternion = callPackage ../development/octave-modules/quaternion { };

    signal = callPackage ../development/octave-modules/signal { };

    struct = callPackage ../development/octave-modules/struct { };

    symbolic = callPackage ../development/octave-modules/symbolic {
      # Need to use sympy 1.5.1 for https://github.com/cbm755/octsympy/issues/1023
      # It has been addressed, but not merged yet.
      python2Packages = pkgs.python2Packages;
    };

  })
