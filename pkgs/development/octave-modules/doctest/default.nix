{
  buildOctavePackage,
  lib,
  fetchFromGitHub,
}:

buildOctavePackage rec {
  pname = "doctest";
  version = "0.8.2";
  # version = "0.8.3";

  src = fetchFromGitHub {
    owner = "gnu-octave";
    repo = "octave-doctest";
    rev = "383e3412800101901c3eee98988f529a7b7a6285";
    # tag = "v${version}";
    sha256 = "sha256-3HzQMkjpHE7GhcWQ12eRDXdA111Owl357ehPP2CQfEk=";
  };

  meta = {
    homepage = "https://gnu-octave.github.io/packages/doctest/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ravenjoad ];
    description = "Find and run example code within documentation";
    longDescription = ''
      Find and run example code within documentation. Formatted blocks
      of example code are extracted from documentation files and executed
      to confirm their output is correct. This can be part of a testing
      framework or simply to ensure that documentation stays up-to-date
      during software development.
    '';
  };
}
