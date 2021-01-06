{ buildOctaveLibrary
, stdenv
, fetchurl
}:

buildOctaveLibrary rec {
  pname = "level-set";
  version = "0.3.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1rb318gs0avkn5j23xrjwhra4y2f13bahc5v4x5wrm978bcs5xlp";
  };

  meta = with stdenv.lib; {
    name = "Level Set";
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Routines for calculating the time-evolution of the level-set equation and extracting geometric information from the level-set function";
    broken = true;
    # During a simple build, I received the following error while building the package
    # error: structure has no member 'dir'
    # Marking as broken until I resolve it.
  };
}
