{ lib
, stdenv
, fetchTarball
, octave
, gnuplot
, python3
, sympy
, mpmath
, texinfo
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
    python3
    sympy
    mpmath
  ];

  sourceRoot = "source";

  # Empty build phase so that tests in checkPhase are run.
  buildPhase = "";

  OCTAVE_HISTFILE = "/build/.octave_hist";

  doCheck = true;
  checkTarget = "test";
  checkInputs = [
    gnuplot
    texinfo
  ];
  # The Makefile has /bin/bash hardcoded. Switch to using /usr/bin/env bash.
  # As of writing this file, octave as provided by octaveFull is broken (at least
  # on my machine). To get around this, octave-cli still works.
  preCheck = ''
    sed -i s/"\/bin\/bash"/"\/usr\/bin\/env bash"/ Makefile
    sed -i 's/octave/octave-cli/' Makefile
    # Octave writes the commands run during testing to OCTAVE_HISTFILE
    touch $OCTAVE_HISTFILE
  '';

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
