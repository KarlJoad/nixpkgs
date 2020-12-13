{ lib
, stdenv
, fetchTarball
, octave
}:

stdenv.mkDerivation rec {
  pname = "linear-algebra";
  version = "2.2.3";

  src = builtins.fetchTarball {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1plhw95dadddfa7bxm42z6xmif1izcvqfsd1gj1i0prwr3cpzify";
  };

  propagatedBuildInputs = [
    octave
  ];

  installPhase = ''
    mkdir -p $out/
    cp -r $src/inst/* $out/
  '';

  phases = [ "unpackPhase" "installPhase" ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    licenses = with lib.licenses; [ gpl3Plus
                                    lgpl3Plus
                                    bsd
                                  ];
    maintainers = with lib.maintainers; [ KarlJoad ];
    description = "Additional linear algebra code, including matrix functions";
  };
}
