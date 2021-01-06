{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "struct";
  version = "1.0.16";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0gx20r126f0ccl4yflp823xi77p8fh4acx1fv0mmcsglmx4c4vgm";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Additional structure manipulation functions";
  };
}
