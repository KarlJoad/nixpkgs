{ buildOctavePackage
, lib
, fetchurl
, struct
, statistics
, lapack
, blas
}:

buildOctavePackage rec {
  pname = "optim";
  version = "1.6.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1z2h8gy99glxh5qi3r22am2vdirlbklkq0lx4r8jrx1ak7awh47r";
  };

  buildInputs = [
    lapack
    blas
  ];

  requiredOctavePackages = [
    struct
    statistics
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ gpl3Plus publicDomain ];
    # Modified BSD code seems removed
    maintainers = with maintainers; [ KarlJoad ];
    description = "Non-linear optimization toolkit";
  };
}
