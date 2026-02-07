{
  lib,
  stdenv,
  fetchurl,
  appimageTools,
  undmg,
  ...
}:
let
  pname = "hytale-f2p";
  version = "2.2.1";

  sources = {
    x86_64-linux = {
      url = "https://github.com/amiayweb/Hytale-F2P/releases/download/v2.2.1/hytale-f2p-launcher_2.2.1.AppImage";
      hash = "sha256-mh84zniMiO9hTRgTR2yz1vJDAHgonfWHCad2oAKW78A=";
    };
  };

  src = fetchurl (
    sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}")
  );

  meta = with lib; {
    description = "free hytale ";
    homepage = "https://github.com/amiayweb/Hytale-F2P";
    license = licenses.mit;
    platforms = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    maintainers = [ ];
  };
  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: [
    pkgs.icu
    pkgs.libpng
  ];
}
