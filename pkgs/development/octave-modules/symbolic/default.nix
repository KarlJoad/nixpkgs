{ lib
, stdenv
, fetchTarball
, octave
, python
, sympy
, mpmath
}:

stdenv.mkDerivation rec {
  pname = "symbolic";
  version = "2.9.0";

  src = fetchTarball {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "08l8baf4641mfcmf9bjrxi0zdh9728vwpg5nckim8jmp1b5qbxcd";
  };

  buildInputs = [
    octave
  ];

  propagatedBuildInputs = [
    python
    sympy
    mpmath
  ];

  sourceRoot = "source";

  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
  '';

  phases = [ "unpackPhase" "installPhase" ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}
