{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "grpcurl";
  version = "1.9.2";

  src = fetchFromGitHub {
    owner = "fullstorydev";
    repo = "grpcurl";
    rev = "v${version}";
    sha256 = "sha256-0AnQxEe9jo8R++ALamTkgpaauvDaH4CaHgmwLyBTr3w=";
  };

  subPackages = [ "cmd/grpcurl" ];

  vendorHash = "sha256-e/V6MMYGqhZ2Ei7+2XhSsCXJNiwsTPa2Q43rdkns45o=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  meta = with lib; {
    description = "Like cURL, but for gRPC: Command-line tool for interacting with gRPC servers";
    homepage = "https://github.com/fullstorydev/grpcurl";
    license = licenses.mit;
    maintainers = with maintainers; [ knl ];
    mainProgram = "grpcurl";
  };
}
