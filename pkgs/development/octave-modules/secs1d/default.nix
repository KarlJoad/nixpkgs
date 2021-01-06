{ buildOctaveLibrary
, stdenv
, fetchurl
, bim
}:

buildOctaveLibrary rec {
  pname = "secs1d";
  version = "0.0.9";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1a4ad16130vnlrvjlkkgfsv8l6abzgsl8wam7kz8wiwjzw1sp8s8";
  };

  buildInputs = [
    bim
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "A Drift-Diffusion simulator for 1d semiconductor devices";
  };
}
