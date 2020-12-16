{ stdenv
, fetchurl
, octave
, enableJava ? true
, jdk ? null
}:

stdenv.mkDerivation rec {
  pname = "io";
  version = "2.6.3";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "044y8lfp93fx0592mv6x2ss0nvjkjgvlci3c3ahav76pk1j3rikb";
  };

  buildInputs = [
    octave
  ]
  ++ (stdenv.lib.optional (enableJava) jdk);

  sourceRoot = "${pname}-${version}";

  OCTAVE_HISTFILE = "/build/.octave_hist";

  preBuild = ''
    cd src
  '';

  postBuild = ''
    mkdir -p $out/
    cp *.oct $out/
  '';

  installPhase = ''
    cd .. # Return to sourceRoot
    cp -r inst/* $out/
    # Copy the documentation
    cp -r doc $out/
  '';

  postInstall = ''
    # Copy the distribution information.
    mkdir -p $out/packinfo
    cp COPYING DESCRIPTION INDEX NEWS $out/packinfo/
  '';

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with stdenv.lib.licenses; [ gpl3Plus bsd2 ];
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}
