{ buildOctaveLibrary
, stdenv
, fetchurl
, autoreconfHook
, gfortran
, lapack, blas
}:

buildOctaveLibrary rec {
  pname = "control";
  version = "3.2.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0gjyjsxs01x0nyc4cgn3d5af17l3lzs8h4hsm57nxd3as48dbwgs";
  };

  root = "${pname}-${version}";

  nativeBuildInputs = [
    gfortran
    autoreconfHook
  ];

  buildInputs = [
    lapack blas
  ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Signal processing tools, including filtering, windowing and display functions";
  };
}
