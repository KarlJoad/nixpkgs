{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "splines";
  version = "1.3.3";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "16wisph8axc5xci0h51zj0y0x2wj6c9zybi2sjpb9v8z9dagjjqa";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ gpl3Plus publicDomain ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "Additional spline functions";
  };
}
