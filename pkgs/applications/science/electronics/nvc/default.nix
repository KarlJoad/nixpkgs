{ lib, stdenv, fetchFromGitHub
, automake, autoconf, autoreconfHook
, flex, check, llvm, libllvm, libdwarf
, pkgconfig, zlib, elfutils
}:

stdenv.mkDerivation rec {
  pname = "nvc";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "nickg";
    repo = "nvc";
    rev = "r${version}";
    sha256 = "0m1zhcqhgz5fajz98ky5zdv8g8gvk9caghqfpbv8q3mzdzahcsx5";
  };

  sourceRoot = "source";

  configureFlags = [
    "--with-llvm=${libllvm.dev}/bin/llvm-config"
    "--enable-vhpi"
  ];

  enableParallelBuilding = true;
  nativeBuildInputs = [ automake autoconf autoreconfHook
                        flex llvm libllvm libllvm.dev libdwarf
                        pkgconfig zlib elfutils
                      ];

  doCheck = true;
  checkTarget = "check";
  checkInputs = [ check ];

  # Include Ruby scripts to compile simulation libraries of FPGA vendors.
  postInstall = ''
    cp -r $src/tools $out/
  '';

  meta = with lib; {
    description = "VHDL compiler and simulator aiming for IEEE 1076-2002 compliance";
    homepage    = "https://github.com/nickg/nvc";
    license     = with licenses; [ gpl3Plus ];
    platforms   = platforms.unix;
    maintainers = with maintainers; [ KarlJoad ];
  };
}
