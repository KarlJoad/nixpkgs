{stdenv
, fetchurl
, octave
, python
, control
}:

stdenv.mkDerivation rec {
  pname = "signal";
  version = "1.4.1";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1amfh7ifjqxz2kr34hgq2mq8ygmd5j3cjdk1k2dk6qcgic7n0y6r";
  };

  buildInputs = [
    octave
  ];

  propagatedBuildInputs = [
    python
    control
  ];

  sourceRoot = "source/src";

  postBuild = ''
    mkdir -p $out/
    cp *.oct $out/
  '';

  installPhase = ''
    # Copy all the Octave files, with the package's functions, out.
    cp -r $src/inst/* $out/
  '';

  postInstall = ''
    # Copy the distribution information.
    mkdir -p $out/packinfo
    cp $src/COPYING $src/DESCRIPTION $src/INDEX $src/NEWS $out/packinfo/
  '';

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Signal processing tools, including filtering, windowing and display functions";
  };
}
