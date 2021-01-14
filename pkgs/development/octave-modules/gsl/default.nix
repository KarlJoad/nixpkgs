{ buildOctavePackage
, stdenv
, fetchurl
, gslPackage
}:

buildOctavePackage rec {
  pname = "gsl";
  version = "2.1.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1lvfxbqmw8h1nlrxmvrl6j4xffmbzxfhdpxz3vrc6lg2g4jwaa6h";
  };

  buildInputs = [
    gslPackage
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Octave bindings to the GNU Scientific Library";
  };
}
