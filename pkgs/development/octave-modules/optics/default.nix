{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "optics";
  version = "0.1.4";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1d9z82241a1zmr8m1vgw10pyk81vn0q4dcyx7d05pigfn5gykrgc";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Functions covering various aspects of optics";
  };
}
