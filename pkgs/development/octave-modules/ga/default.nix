{ buildOctavePackage
, lib
, fetchurl
}:

buildOctavePackage rec {
  pname = "ga";
  version = "0.10.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0s5azn4n174avlmh5gw21zfqfkyxkzn4v09q4l9swv7ldmg3mirv";
  };

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Genetic optimization code";
  };
}
