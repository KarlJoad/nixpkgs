{ buildOctavePackage
, lib
, fetchurl
}:

buildOctavePackage rec {
  pname = "quaternion";
  version = "2.4.0";

  src = fetchurl {
    url = "mirror://sourceforge/octave/${pname}-${version}.tar.gz";
    sha256 = "040ncksf0xz32qmi4484xs3q01nappxrsvwwa60g04yjy7c4sbac";
  };

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/quaternion/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Quaternion package for GNU Octave, includes a quaternion class with overloaded operators";
    # Marked this way because of build error "s_real_array.cc:50:34: error: 'const class octave_value' has no member named 'is_bool_type'"
    broken = true;
  };
}
