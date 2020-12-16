{ stdenv
, fetchurl
, octave
}:

stdenv.mkDerivation rec {
  pname = "linear-algebra";
  version = "2.2.3";

  src = builtins.fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1wwjpxp9vjc6lszh0z3kgy4hyzpib8rvvh6b74ijh9qk9r9nmvjk";
  };

  buildInputs = [
    octave
  ];

  installPhase = ''
    mkdir -p $out/
    cp -r $src/inst/* $out/
  '';

  phases = [ "unpackPhase" "installPhase" ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    licenses = with stdenv.lib.licenses; [ gpl3Plus
                                           lgpl3Plus
                                           bsd
                                         ];
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Additional linear algebra code, including matrix functions";
  };
}
