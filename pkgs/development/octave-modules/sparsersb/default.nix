{ buildOctavePackage
, lib
, fetchurl
, librsb
}:

buildOctavePackage rec {
  pname = "sparsersb";
  version = "1.0.8";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0nl7qppa1cm51188hqhbfswlih9hmy1yz7v0f5i07z0g0kbd62xw";
  };

  buildInputs = [
    librsb
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Interface to the librsb package implementing the RSB sparse matrix format for fast shared-memory sparse matrix computations";
    # Mark this way until KarlJoad builds librsb specifically for this package.
    broken = true;
  };
}
