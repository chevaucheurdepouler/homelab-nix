{stdenv, fetchFromGitHub}: 
stdenv.mkDerivation {
  pname = "miku-cursor-linux";
  version = "1.2.6";

  src = fetchFromGitHub {
    owner = "supermariofps";
    repo = "hatsune-miku-windows-linux-cursors";
    rev = "v${1.2.6}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

}
