{ buildOctavePackage
, lib
, fetchurl
, netcdfPackage
}:

buildOctavePackage rec {
  pname = "netcdf";
  version = "1.0.14";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1wdwl76zgcg7kkdxjfjgf23ylzb0x4dyfliffylyl40g6cjym9lf";
  };

  buildInputs = [
    netcdfPackage
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "A NetCDF interface for Octave";
  };
}
