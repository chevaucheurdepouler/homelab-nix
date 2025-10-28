{
  stdenv,
  pkgs,
  fetchzip,
}:
stdenv.mkDerivation {
  pname = "beatoraja";
  version = "0.8.8";

  src = fetchzip {
    url = "https://mocha-repository.info/download/beatoraja0.8.8-modernchic.zip";
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
