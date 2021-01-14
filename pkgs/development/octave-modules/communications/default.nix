{ buildOctavePackage
, stdenv
, fetchurl
, signal
, hdf5
}:

buildOctavePackage rec {
  pname = "communications";
  version = "1.2.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1xay2vjyadv3ja8dmqqzm2his8s0rvidz23nq1c2yl3xh1gavyck";
  };

  buildInputs = [
    signal
    hdf5
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = " Digital Communications, Error Correcting Codes (Channel Code), Source Code functions, Modulation and Galois Fields";
  };
}
