{ buildOctavePackage
, stdenv
, fetchurl
# Build-time dependencies
, termcap
, libncurses # >= 5
, units
}:

buildOctavePackage rec {
  pname = "miscellaneous";
  version = "1.3.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "10n107njz24ln7v9a1l3dkh7s7vd6qwgbinrj1nl4wflxsir4l9k";
  };

  buildInputs = [
    termcap
    libncurses
    units
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Miscellaneous tools that don't fit somewhere else";
    # Marked this way until units is a runtime dependency.
    broken = true;
  };
}
