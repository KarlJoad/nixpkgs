{ buildOctavePackage
, lib
, fetchurl
, fftw
, fftwSinglePrec
, fftwFloat
, fftwLongDouble
, lapack
, blas
, portaudio
, jre
}:

buildOctavePackage rec {
  pname = "ltfat";
  version = "2.3.1";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "0gghh5a4w649ff776wvidfvqas87m0n7rqs960pid1d11bnyqqrh";
  };

  buildInputs = [
    fftw
    fftwSinglePrec
    fftwFloat
    fftwLongDouble
    lapack
    blas
    portaudio
    jre
  ];

  meta = with lib; {
    name = "The Large Time-Frequency Analysis Toolbox";
    homepage = "https://octave.sourceforge.io/ltfat/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Toolbox for working with time-frequency analysis, wavelets and signal processing";
    longDescription = ''
      The Large Time/Frequency Analysis Toolbox (LTFAT) is a Matlab/Octave
      toolbox for working with time-frequency analysis, wavelets and signal
      processing. It is intended both as an educational and a computational
      tool. The toolbox provides a large number of linear transforms including
      Gabor and wavelet transforms along with routines for constructing windows
      (filter prototypes) and routines for manipulating coefficients.
    '';
    broken = true;
    # During a simple build, I received the following error while building documentation.
    # error: parse error near line 153 of file /nix/store/hash-octave-6.1.0-env/share/octave/octave_packages/ltfat-2.3.1/nonstatgab/nsdgt.m
    # syntax error times,f(win_range,:),g{ii}(idx));
    # Marking as broken until I resolve it.
  };
}
