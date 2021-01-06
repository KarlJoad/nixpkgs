{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "optiminterp";
  version = "0.3.6";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "05nzj2jmrczbnsr64w2a7kww19s6yialdqnsbg797v11ii7aiylc";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "An optimal interpolation toolbox for octave";
    longDescription = ''
       An optimal interpolation toolbox for octave. This package provides
       functions to perform a n-dimensional optimal interpolations of
       arbitrarily distributed data points.
    '';
    # Marked this way because of configure error
    # configure: error: mkoctfile does not accept files with the extention .F90. Support for this file extension has been added to version 2.9.9 of octave.
    broken = true;
  };
}
