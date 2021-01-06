{ buildOctaveLibrary
, stdenv
, fetchurl
, io # >= 2.2.7
, geometry # >= 4.0.0
}:

buildOctaveLibrary rec {
  pname = "mapping";
  version = "1.4.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0wj0q1rkrqs4qgpjh4vn9kcpdh94pzr6v4jc1vcrjwkp87yjv8c0";
  };

  buildInputs = [
    io
    geometry
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Simple mapping and GIS .shp .dxf and raster file functions";
  };
}
