{ buildOctavePackage
, lib
, fetchurl
}:

buildOctavePackage rec {
  pname = "octclip";
  version = "2.0.1";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "05ijh3izgfaan84n6zp690nap9vnz0zicjd0cgvd1c6askm7vxql";
  };

  meta = with lib; {
    name = "GNU Octave Clipping Polygons Tool";
    homepage = "https://octave.sourceforge.io/octclip/index.html";
    license = with licenses; [ gpl3Plus ]; # modified BSD?
    maintainers = with maintainers; [ KarlJoad ];
    description = "Perform boolean operations with polygons using the Greiner-Hormann algorithm";
    # Marked this way because of build error "_oc_polybool.cc:220:19: error: format not a string literal and no format arguments [-Werror=format-security]"
    broken = true;
  };
}
