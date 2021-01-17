{ buildOctavePackage
, lib
, fetchurl
, cfitsio
}:

buildOctavePackage rec {
  pname = "fits";
  version = "1.0.7";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0jab5wmrpifqphmrfkqcyrlpc0h4y4m735yc3avqqjajz1rl24lm";
  };

  buildInputs = [
    cfitsio
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/fits/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Functions for reading, and writing FITS (Flexible Image Transport System) files using cfitsio";
    # Marked this way until KarlJoad gets cfitsio as a runtime dependency.
    broken = true;
  };
}
