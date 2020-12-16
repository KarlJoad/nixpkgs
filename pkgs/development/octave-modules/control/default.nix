{ stdenv
, fetchurl
, octave
, gfortran
, autoreconfHook
, lapack, blas
}:

stdenv.mkDerivation rec {
  pname = "control";
  version = "3.2.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0gjyjsxs01x0nyc4cgn3d5af17l3lzs8h4hsm57nxd3as48dbwgs";
  };

  buildInputs = [
    octave
    gfortran
    autoreconfHook
  ];

  propagatedBuildInputs = [
    lapack blas
  ];

  sourceRoot = "${pname}-${version}/src";

  postBuild = ''
    mkdir -p $out/
    cp *.oct $out/
  '';

  installPhase = ''
    # Currently in $sourceRoot. End up in root of unpack.
    cd ..
    # Copy all the Octave files, with the package's functions, out.
    cp -r inst/* $out
  '';

  postInstall = ''
    # Copy the distribution information.
    mkdir -p $out/packinfo
    cp COPYING DESCRIPTION INDEX NEWS $out/packinfo/
  '';

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Signal processing tools, including filtering, windowing and display functions";
  };
}
