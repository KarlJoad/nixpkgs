{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "ocs";
  version = "0.1.5";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "04r0s02v2gkx29n4a0l3zs4wjg2vbwxgrzqn48krc7l727gbqw0k";
  };

  meta = with stdenv.lib; {
    name = "Octave Circuit Simulator";
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Package for solving DC and transient electrical circuit equations";
    # Marked this way because of a build error "error: structure has no member 'dir'"
    broken = true;
  };
}
