{ buildOctaveLibrary
, stdenv
, fetchurl
, pcre
}:

buildOctaveLibrary rec {
  pname = "strings";
  version = "1.2.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1b0ravfvq3bxd0w3axjfsx13mmmkifmqz6pfdgyf2s8vkqnp1qng";
  };

  buildInputs = [
    pcre
  ];

  meta = with stdenv.lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    # Claims to have a freebsd license, but I found none.
    maintainers = with maintainers; [ KarlJoad ];
    description = "Additional functions for manipulation and analysis of strings";
    # Marked this way because of build error "error: 'gripe_wrong_type_arg' was not declared in this scope"
    broken = true;
  };
}
