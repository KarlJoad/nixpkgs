{ buildOctavePackage
, lib
, fetchurl
, dolfin
, fenics
, pkg-config
}:

buildOctavePackage rec {
  pname = "fem-fenics";
  version = "0.0.5";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "1xd80nnkschldvrqx0wvrg3fzbf8sck8bvq24phr5x49xs7b8x78";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    dolfin
    fenics
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/fem-fenics/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Package for the resolution of partial differential equations based on fenics";
    # Marked this way until KarlJoad gets dolfin and fenics as runtime dependencies.
    broken = true;
  };
}
