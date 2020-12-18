{ buildOctaveLibrary
, stdenv
, fetchurl
, enableJava ? true
, jdk ? null
}:

buildOctaveLibrary rec {
  pname = "io";
  version = "2.6.3";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "044y8lfp93fx0592mv6x2ss0nvjkjgvlci3c3ahav76pk1j3rikb";
  };


  root = "${pname}-${version}";

  buildInputs = stdenv.lib.optional enableJava jdk;

  postInstall = ''
    # Copy the documentation
    cp -r doc $out/
  '';

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with stdenv.lib.licenses; [ gpl3Plus bsd2 ];
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}
