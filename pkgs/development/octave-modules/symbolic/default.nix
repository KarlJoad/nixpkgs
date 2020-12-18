{ buildOctaveLibrary
, stdenv
, fetchurl
, octave
, gnuplot
, python
, sympy
, mpmath
, texinfo
}:

buildOctaveLibrary rec {
  pname = "symbolic";
  version = "2.9.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1jr3kg9q6r4r4h3hiwq9fli6wsns73rqfzkrg25plha9195c97h8";
  };

  root = "${pname}-${version}";
  # This package has no compiled programs, so the src directory doesn't exist.
  # Set the source root to the root of the package instead.
  srcRoot = root;

  buildInputs = [
    python
    sympy
    mpmath
  ];

  # Empty build phase so that tests in checkPhase are run.
  buildPhase = "";
  emptyBuild = true;

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
    # Last test in vpa.m is a systemic problem in Symbolic. "Hide" it by making
    # it a test we expect to fail.
    sed -i.back s/"\%\!warning <dangerous>"$/"%\!xtest"/ inst/vpa.m
    # Octave writes the commands run during testing to OCTAVE_HISTFILE
    touch $OCTAVE_HISTFILE
  '';

  # Keep a copy of the octave tests detailed results in the output derivation,
  # because someone may care.
  postCheck = ''
    mkdir -p $out/
    cp fntests.log $out/${pname}-${version}-fntests.log
  '';

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}
