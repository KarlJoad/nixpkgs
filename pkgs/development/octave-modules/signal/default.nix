{ pkgs ? import <nixpkgs> {}
, lib ? import <nixpkgs/lib> {}
# , stdenv
# , fetchTarball
# , control ? octavePackages.control
}:

with pkgs;

stdenv.mkDerivation rec {
  pname = "signal";
  version = "1.4.1";

  control = import ../control { };

  src = fetchTarball {
    url = "https://octave.sourceforge.io/download.php?package=${pname}-${version}.tar.gz";
    sha256 = "1147ji1q5nlnl2ry9nv1z7mbc0fn54sday06v1r2qzvjw8q8z61d";
  };

  buildInputs = [
    octave
  ];

  propagatedBuildInputs = [
    python
    control
  ];


  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;
  dontCheck = true;

  installPhase = ''
    mkdir -p $out/
    cp -r $src/inst/* $out/
    mkdir -p $out/packinfo
    cp $src/COPYING $src/DESCRIPTION $src/INDEX $src/NEWS $out/packinfo/
  '';

  # dontInstall = true;
  dontFixup = true;
  dontInstallCheckPhase = true;
  dontDistPhase = true;

  meta = {
    homepage = "https://octave.sourceforge.io/${pname}/index.html";
    license = stdenv.lib.licenses.gpl3Plus;
    maintainers = with maintainers; [ KarlJoad ];
    description = "Signal processing tools, including filtering, windowing and display functions";
  };
}
