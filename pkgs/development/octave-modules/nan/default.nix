{ buildOctavePackage
, stdenv
, fetchurl
, blas
}:

buildOctavePackage rec {
  pname = "nan";
  version = "3.5.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0bp8zl50f8qj5sivl88kjdswm035v4li33fiq3v1gmh0pvgbcw7a";
  };

  buildInputs = [
    blas
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "A statistics and machine learning toolbox for data with and w/o missing values";
  };
}
