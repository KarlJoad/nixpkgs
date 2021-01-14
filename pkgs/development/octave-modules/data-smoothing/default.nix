{ buildOctavePackage
, stdenv
, fetchurl
, optim
}:

buildOctavePackage rec {
  pname = "data-smoothing";
  version = "1.3.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0q0vqdmp8ygyfhk296xbxcpsh5wvpa2kfgv4v0rys68nd2lxfaq1";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Algorithms for smoothing noisy data";
  };
}
