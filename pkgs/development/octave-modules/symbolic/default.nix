{ buildOctaveLibrary
, stdenv
, fetchurl
, octave
, gnuplot
, pythonEnv
, texinfo
}:

buildOctaveLibrary rec {
  pname = "symbolic";
  version = "2.9.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1jr3kg9q6r4r4h3hiwq9fli6wsns73rqfzkrg25plha9195c97h8";
  };

  buildInputs = [ pythonEnv ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}
