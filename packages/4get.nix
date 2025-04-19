{ stdenv, fetchFromGitea }:
stdenv.mkDerivation {
  pname = "4get";
  version = "1.2.6";

  src = {
    owner = "lolcat";
    domain = "git.lolcat.ca";
    repo = "4get";
    rev = "1.2.6";
    hash = "sha256-OQjjOc9VnxJ7tWNmpHIMzNWX6WsavAOkgPwK1XAMwtE=";
  };

  installPhase = ''
    runHook preInstall
    cd lolcat

    mkdir -p $out/share/icons/miku-cursor-linux
    cp -r * $out/share/icons/miku-cursor-linux
    install -m644 index.theme $out/share/icons/miku-cursor-linux/index.theme




    runHook postInstall
  '';

}
