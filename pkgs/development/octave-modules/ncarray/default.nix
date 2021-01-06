{ buildOctaveLibrary
, stdenv
, fetchurl
, netcdf
, statistics
}:

buildOctaveLibrary rec {
  pname = "ncarray";
  version = "1.0.4";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0v96iziikvq2v7hczhbfs9zmk49v99kn6z3lgibqqpwam175yqgd";
  };

  buildInputs = [
    netcdf
    statistics
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Access a single or a collection of NetCDF files as a multi-dimensional array";
  };
}
