{ buildOctavePackage
, stdenv
, fetchurl
# Octave dependencies
, linear-algebra
, miscellaneous
, struct
, statistics
# Runtime dependencies
, freewrl
}:

buildOctavePackage rec {
  pname = "vrml";
  version = "1.0.13";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1mx93k150agd27mbzvds13v9z0x36j68hwpdvlvjmcl2fga5fly4";
  };

  buildInputs = [
    linear-algebra
    miscellaneous
    struct
    statistics
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = with licenses; [ gpl3Plus fdl12Plus ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "3D graphics using VRML";
    # Marked this way until KarlJoad gets freewrl as a runtime dependency.
    broken = true;
  };
}
