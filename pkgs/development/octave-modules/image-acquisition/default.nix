{ buildOctavePackage
, stdenv
, fetchurl
, libv4l
, libfltk
}:

buildOctavePackage rec {
  pname = "image-acquisition";
  version = "0.2.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1amp6npkddnnz2i5rm6gvn65qrbn0nxzl2cja3dvc2xqg396wrhh";
  };

  buildInputs = [
    libv4l
    libfltk
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Functions to capture images from connected devices";
    longDescription = ''
      The Octave-forge Image Aquisition package provides functions to
      capture images from connected devices. Currently only v4l2 is supported.
    '';
  };
}
