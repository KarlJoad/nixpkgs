{ buildOctaveLibrary
, stdenv
, fetchurl
, octave
, gnuplot
, pythonEnv
, texinfo
}:

(buildOctaveLibrary rec {
  pname = "symbolic";
  version = "2.9.0";

  src = fetchurl {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1jr3kg9q6r4r4h3hiwq9fli6wsns73rqfzkrg25plha9195c97h8";
  };

  buildInputs = [ pythonEnv ];

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with stdenv.pkgs.maintainers; [ KarlJoad ];
    description = "Adds symbolic calculation features to GNU Octave";
  };
}).overrideAttrs (oldAttrs: rec {
  dontUnpack = false;
  buildPhase = ''
      substituteInPlace inst/private/defaultpython.m --replace python3 ${pythonEnv}/bin/python
    '';
  dontInstall = false;
  installPhase = ''
      mkdir -p $out
      # This trickery is needed because Octave expects a single directory inside
      # at the top-most level of the tarball.
      tar --transform 's,^,${oldAttrs.packageName}/,' -cz * -f $out/${oldAttrs.packageName}.tar.gz
    '';
})
