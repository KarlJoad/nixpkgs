{ buildOctavePackage
, stdenv
, fetchurl
, libgdcm
}:

buildOctavePackage rec {
  pname = "dicom";
  version = "0.4.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "131wn6mrv20np10plirvqia8dlpz3g0aqi3mmn2wyl7r95p3dnza";
  };

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Digital communications in medicine (DICOM) file io";
    # Marked this way until KarlJoad gets libgdcm >= 2.0.16 as a runtime dependency.
    broken = true;
  };
}
