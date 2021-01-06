{ buildOctaveLibrary
, stdenv
, fetchurl
, instrument-control
, arduino
}:

buildOctaveLibrary rec {
  pname = "arduino";
  version = "0.6.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0fnfk206n31s7diijaylmqhxnr88z6l3l3vsxq4z8gcp9ylm9nkj";
  };

  buildInputs = [
    instrument-control
  ];

  meta = with stdenv.lib; {
    name = "Octave Arduino Toolkit";
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = " Basic Octave implementation of the matlab arduino extension, allowing communication to a programmed arduino board to control its hardware";
    # Marked this way until KarlJoad gets an arduino IDE as a runtime dependency.
    broken = true;
  };
}
