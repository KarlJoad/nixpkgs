{ lib
, stdenv
, fetchFromGitHub
, cmake
, wrapQtAppsHook
, qtbase
, qtsvg
}:

stdenv.mkDerivation rec {
  pname = "VIBes";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "ENSTABretagneRobotics";
    repo = "VIBES";
    rev = version;
    sha256 = "03sh24lif9bl7hnsgblmhya0v5q9m0fpmh7g7ps6jvj3gzm8a0am";
  };

  sourceRoot = "source/viewer";

  nativeBuildInputs = [
    cmake
    qtbase qtsvg
    wrapQtAppsHook
  ];

  dontWrapQtApps = false;

  meta = with lib; {
    homepage = "https://github.com/ENSTABretagneRobotics/VIBES";
    description = "Visualization system working with interval methods to display results (boxes, pavings), without worrying with GUI programming";
    longDescription = ''
      A visualization system that aims at providing people working with interval
      methods a way to display results (boxes, pavings), without worrying with
      GUI programming. It provides drawing functions accessible from a lot of
      programming languages, without complex installation and library
      dependencies. The main design goal of VIBes is to be cross-platform,
      available from different programming languages, simple to set-up, easy to
      port to a new language.
    '';
    # License is a big ?, because their license is completely empty.
    # I am assuming it is licenses.free for now.
    license = with licenses; [ free ];
    maintainers = with maintainers; [ KarlJoad ];
  };
}
