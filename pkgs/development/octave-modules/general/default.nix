{ buildOctaveLibrary
, stdenv
, fetchurl
, autoreconfHook
, pkgconfig
, nettle
}:

buildOctaveLibrary rec {
  pname = "general";
  version = "2.1.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0jmvczssqz1aa665v9h8k9cchb7mg3n9af6b5kh9b2qcjl4r9l7v";
  };

  root = "${pname}-${version}";

  nativeBuildInputs = [
    autoreconfHook
    pkgconfig
    nettle
  ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Computer-Aided Control System Design (CACSD) Tools for GNU Octave, based on the proven SLICOT Library";
  };
}
