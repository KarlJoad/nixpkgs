{stdenv
, fetchTarball
, octave
, gfortran
, autoreconfHook
, lapack, blas, flibs
}:

stdenv.mkDerivation rec {
  pname = "control";
  version = "3.2.0";

  src = fetchTarball {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1l9lr3fxmjf8j900jrgcc7qffymmkmnnar4ahvaap87blgv07wcm";
  };

  buildInputs = [
    octave
    gfortran
    autoreconfHook
  ];

  propagatedBuildInputs = [
    lapack blas
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
