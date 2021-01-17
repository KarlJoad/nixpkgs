{ buildOctavePackage
, lib
, fetchurl
, ffmpeg
, libav
}:

buildOctavePackage rec {
  pname = "video";
  version = "2.0.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "0s6j3c4dh5nsbh84s7vnd2ajcayy1gn07b4fcyrcynch3wl28mrv";
  };

  buildInputs = [
    ffmpeg
    libav
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/video/index.html";
    license = with licenses; [ gpl3Plus bsd3 ];
    maintainers = with maintainers; [ KarlJoad ];
    description = "Wrapper for OpenCV's CvCapture_FFMPEG and CvVideoWriter_FFMPEG";
    # Marked this way due to configure error "error: FFmpeg libswscale, libavformat, libavcodec or libavutil not found"
    broken = true;
  };
}
