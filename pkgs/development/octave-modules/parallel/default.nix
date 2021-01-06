{ buildOctaveLibrary
, stdenv
, fetchurl
, struct
, gnutls
, pkg-config
}:

buildOctaveLibrary rec {
  pname = "parallel";
  version = "4.0.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0wmpak01rsccrnb8is7fsjdlxw15157sqyf9s2fabr16yykfmvi8";
  };

  buildInputs = [
    struct
    gnutls
    pkg-config
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Parallel execution package";
  };
}
