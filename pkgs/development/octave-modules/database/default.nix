{ buildOctavePackage
, stdenv
, fetchurl
, struct
, postgresql
}:

buildOctavePackage rec {
  pname = "database";
  version = "2.4.4";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1c0n76adi0jw6bx62s04vjyda6kb6ca8lzz2vam43vdy10prcq9p";
  };

  propagatedBuildInputs = [
    postgresql
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Interface to SQL databases, currently only postgresql using libpq";
  };
}
