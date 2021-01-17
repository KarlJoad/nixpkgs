{ buildOctavePackage
, lib
, fetchurl
, rtmidi
}:

buildOctavePackage rec {
  pname = "audio";
  version = "2.0.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "18lyvwmdy4b9pcv5sm7g17n3is32q23daw8fcsalkf4rj6cc6qdk";
  };

  nativeBuildInputs = [
    rtmidi
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/audio/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Audio and MIDI Toolbox for GNU Octave";
    # Marked this way until KarlJoad gets rtmidi as a runtime dependency.
    broken = true;
    # Also refuses to build right now.
    # configure: error: RTMIDI required to install octave midi package
    # error: structure has no member 'dir'
  };
}
