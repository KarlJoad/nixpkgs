{ buildOctavePackage
, stdenv
, fetchurl
}:

buildOctavePackage rec {
  pname = "lssa";
  version = "0.1.4";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "10h9lzsi7pqh93i7y50b618g05fnbw9n0i505bz5kz4avfa990zh";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Tools to compute spectral decompositions of irregularly-spaced time series";
    longDescription = ''
       A package implementing tools to compute spectral decompositions of
       irregularly-spaced time series. Currently includes functions based off
       the Lomb-Scargle periodogram and Adolf Mathias' implementation for R
       and C.
    '';
  };
}
