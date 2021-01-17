{ stdenv
, lib
, fetchurl
, autoconf
, libtool
, automake
, pkg-config
, zlib
, unzip
, wget
# XML Requirements
, libxml2, expat
# X requirements
, libXaw, libXaw3d
, libICE, libSM
, libXmu, libXpm
# Jpeg, PNG, TIFF, GIF headers
, libjpeg, libjpeg_turbo, libpng, libtiff, giflib
# Image Manipulation
, imagemagick, imlib, imlib2
# Fonts
, freetype, fontconfig
# Sound
, openal, freealut
# Video output
, libGLU, libGL
, motif
# Needed to generate documentation
, doxygen
, enableThreadsColorized ? true
, enableFontConfig ? true
, enableLibCurl ? false
, libcurl ? null
, buildLibeai ? true
, disableSound ? false
, disablePlugins ? false
, enable2D ? true
, enableSTLParseSupport ? false
, enableJava ? false
, jre ? null
}:

stdenv.mkDerivation rec {
  pname = "freewrl";
  version = "3.0.0";

  src = fetchurl {
    url = "https://sourceforge.net/projects/freewrl/files/freewrl-linux/3.0/freewrl-3.0.0.tar.bz2";
    sha256 = "1srwdi8g7ag1rb65swmxxawgm00053z3760zjm92s344va7jxawi";
  };

  configureFlags = with lib; [
    "--enable-docs"
  ]
  ++ optionals enableThreadsColorized [ "--enable-thread_colorized" ]
  ++ optionals enableFontConfig [ "--enable-fontconfig" ]
  ++ optionals enableLibCurl [ "--enable-libcurl" ]
  ++ optionals buildLibeai [ "--enable-libeai" ]
  ++ optionals disableSound [ "--disable-sound" ]
  ++ optionals disablePlugins [ "--disable-plugin" ]
  ++ optionals enable2D [ "--enable-twodee" ]
  ++ optionals enableSTLParseSupport [ "--enable-STL" ]
  ++ optionals enableJava [ "--enable-java" ];

  enableParallelBuilding = true;

  nativeBuildInputs = with lib; [
    autoconf
    libtool
    automake
    pkg-config
    zlib
    unzip
    wget
    libxml2 expat
    doxygen # Used to generate docs

    libXaw libXaw3d
    libICE libSM
    libXmu libXpm

    libjpeg libjpeg_turbo libpng libtiff giflib

    imagemagick imlib imlib2

    openal freealut
    libGLU libGL
  ]
  ++ optionals enableLibCurl libcurl
  ++ optionals enableJava jre;

  buildInputs = [
    freetype fontconfig
    motif
  ];

  doCheck = true;

  doInstallCheck = true;

  meta = with lib; {
    description = "X3D/VRML open source viewer";
    homepage = "http://freewrl.sourceforge.net/index.html";
    license = with licenses; [ gpl3Only ];
    maintainers = with maintainers; [ KarlJoad ];
  };
}
