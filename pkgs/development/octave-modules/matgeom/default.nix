{ buildOctavePackage
, stdenv
, fetchurl
}:

buildOctavePackage rec {
  pname = "matgeom";
  version = "1.2.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "05xfmlh1k3mhq8yag7gr8q1ysl1s43vm46fr1i3gcg9b1kkwi8by";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ bsd2 gpl3Plus ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "Geometry toolbox for 2D/3D geometric computing";
  };
}
