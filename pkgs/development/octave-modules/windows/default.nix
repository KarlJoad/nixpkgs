{ buildOctavePackage
, lib
, fetchurl
}:

buildOctavePackage rec {
  pname = "windows";
  version = "1.5.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "05bsf3q816b9vwgmjdm761ybhmk8raq6dzxqvd11brma0granx3a";
  };

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Provides COM interface and additional functionality on Windows";
  };
}
