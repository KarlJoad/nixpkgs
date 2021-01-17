{ buildOctavePackage
, lib
, fetchurl
, zeromq
}:

buildOctavePackage rec {
  pname = "zeromq";
  version = "1.5.2";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "18h1039ri7dr37jv20cvj5vhw7b57frrda0hhbvlgixinbqmn9j7";
  };

  buildInputs = [
    zeromq
  ];

  meta = with lib; {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "ZeroMQ bindings for GNU Octave";
    # Marked this way until KarlJoad gets zeromq as a runtime dependency.
    broken = true;
  };
}
