{ buildOctaveLibrary
, stdenv
, fetchurl
, matgeom
}:

buildOctaveLibrary rec {
  pname = "geometry";
  version = "4.0.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1zmd97xir62fr5v57xifh2cvna5fg67h9yb7bp2vm3ll04y41lhs";
  };

  buildInputs = [
    matgeom
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ gpl3Plus boost ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "Library for extending MatGeom functionality";
  };
}
