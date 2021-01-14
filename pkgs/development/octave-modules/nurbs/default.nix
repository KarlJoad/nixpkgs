{ buildOctavePackage
, stdenv
, fetchurl
}:

buildOctavePackage rec {
  pname = "nurbs";
  version = "1.3.13";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0zkyldm63pc3pcal3yvj6af24cvpjvv9qfhf0ihhwcsh4w3yggyv";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Collection of routines for the creation, and manipulation of Non-Uniform Rational B-Splines (NURBS), based on the NURBS toolbox by Mark Spink";
    # Marked this way because of build error "error: structure has no member 'dir'"
    broken = true;
  };
}
