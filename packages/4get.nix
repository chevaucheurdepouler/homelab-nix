{
  stdenv,
  pkgs,
  fetchFromGitea,
}:
stdenv.mkDerivation {
  pname = "4get";
  version = "1.2.6";

  src = fetchFromGitea {
    owner = "lolcat";
    domain = "git.lolcat.ca";
    repo = "4get";
    rev = "1.2.6";
    hash = "sha256-OQjjOc9VnxJ7tWNmpHIMzNWX6WsavAOkgPwK1XAMwtE=";
  };

  installPhase = ''
    runHook preInstall
    cd lolcat
    mkdir -p $out/html
    runHook postInstall
  '';

  buildInputs = [
    pkgs.php84
  ];
}
