{stdenv, fetchFromGitHub}: 
stdenv.mkDerivation {
  pname = "miku-cursor-linux";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "supermariofps";
    repo = "hatsune-miku-windows-linux-cursors";
    rev = "1.2.6";
    hash = "sha256-OQjjOc9VnxJ7tWNmpHIMzNWX6WsavAOkgPwK1XAMwtE=";
  };

  postInstall = ''
    mkdir -p $out/share/icons/miku-cursor-linux
    cp -r * $out/share/icons/miku-cursor-linux
  '';

}
