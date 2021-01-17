{ buildOctavePackage
, lib
, fetchurl
, proj # >= 6.3.0
}:

buildOctavePackage rec {
  pname = "octproj";
  version = "2.0.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1mb8gb0r8kky47ap85h9qqdvs40mjp3ya0nkh45gqhy67ml06paq";
  };

  buildInputs = [
    proj
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "GNU Octave bindings to PROJ library for cartographic projections and CRS transformations";
    # Marked this way until KarlJoad gets proj as a runtime dependency.
    # Marked this way because of build error "_op_fwd.cc:139:23: error: format not a string literal and no format arguments [-Werror=format-security]"
    broken = true;
  };
}
