{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "secs2d";
  version = "0.0.8";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1xs5dm596n5khcnvawjl8dfmjabdbgaymxvyin5z11s46bila6ag";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "A Drift-Diffusion simulator for 2d semiconductor devices";
    # Marked this way due to error during octave's configure phase
    broken = true;
  };
}
