{ buildOctaveLibrary
, stdenv
, fetchurl
, bim
, fpl
}:

buildOctaveLibrary rec {
  pname = "secs3d";
  version = "0.0.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0di30lkynyv7vq6zwh8vpz539wq4537xkxcy9aig5k7c5fn8p7qw";
  };

  buildInputs = [
    bim
    fpl
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "A Drift-Diffusion simulator for 3d semiconductor devices";
  };
}
