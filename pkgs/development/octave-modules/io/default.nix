{ buildOctavePackage
, stdenv
, fetchurl
, enableJava ? true
, jdk ? null
, unzip
}:

buildOctavePackage rec {
  pname = "io";
  version = "2.6.3";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "044y8lfp93fx0592mv6x2ss0nvjkjgvlci3c3ahav76pk1j3rikb";
  };

  buildInputs = [
    (stdenv.lib.optional enableJava jdk)
    unzip
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ gpl3Plus bsd2 ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "Input/Output in external formats";
    # Marked this way until KarlJoad makes unzip a run-time dependency
    broken = true;
  };
}
