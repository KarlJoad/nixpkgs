# This file contains the GNU Octave add-on packages set.
# Each attribute is an Octave library.
# Expressions for the Octave libraries are supposed to be in `pkgs/development/octave-modules/<name>/default.nix`.

# When contributing a new package, if that package has a dependency on another
# octave package, then you DO NOT need to explicitly list it as such when
# performing the callPackage. It will be passed implicitly.
# In addition, try to use the same dependencies as the ones octave needs, which
# should ensure greater compatibility between Octave itself and its packages.

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

    communications = callPackage ../development/octave-modules/communications {
      hdf5 = pkgs.hdf5;
    };

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

    queueing = callPackage ../development/octave-modules/queueing { };

    signal = callPackage ../development/octave-modules/signal { };

    sockets = callPackage ../development/octave-modules/sockets { };

    sparsersb = callPackage ../development/octave-modules/sparsersb {
      librsb = null;
      # TODO: Package the librsb library to build this package.
      # http://librsb.sourceforge.net/
    };

    stk = callPackage ../development/octave-modules/stk { };

    splines = callPackage ../development/octave-modules/splines { };

    statistics = callPackage ../development/octave-modules/statistics { };

    strings = callPackage ../development/octave-modules/strings {
      pcre = pkgs.pcre;
    };

    struct = callPackage ../development/octave-modules/struct { };

    symbolic = callPackage ../development/octave-modules/symbolic {
      python2Packages = pkgs.python2Packages;
    };

    tisean = callPackage ../development/octave-modules/tisean { };

    tsa = callPackage ../development/octave-modules/tsa { };

    vibes = callPackage ../development/octave-modules/vibes {
      vibes = null;
      # TODO: Need to package vibes:
      # https://github.com/ENSTABretagneRobotics/VIBES
    };

    video = callPackage ../development/octave-modules/video {
      # Only need ffmpeg OR libav, but both defined for right now.
      ffmpeg = pkgs.ffmpeg;
      libav = pkgs.libav;
    };

    vrml = callPackage ../development/octave-modules/vrml {
      freewrl = null;
    };

    windows = callPackage ../development/octave-modules/windows { };

    zeromq = callPackage ../development/octave-modules/zeromq {
      zeromq = pkgs.zeromq;
    };

  })
