{ buildOctavePackage
, lib
, fetchurl
, instrument-control
, arduino
}:

buildOctavePackage rec {
  pname = "arduino";
  version = "0.6.0";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "0fnfk206n31s7diijaylmqhxnr88z6l3l3vsxq4z8gcp9ylm9nkj";
  };

  requiredOctavePackages = [
    instrument-control
  ];

  propagatedBuildInputs = [
    arduino
  ];

  meta = with lib; {
    name = "Octave Arduino Toolkit";
    homepage = "https://octave.sourceforge.io/arduino/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Basic Octave implementation of the matlab arduino extension, allowing communication to a programmed arduino board to control its hardware";
    # Marked this way until KarlJoad gets an arduino IDE as a runtime dependency.
    broken = true;
  };
}
