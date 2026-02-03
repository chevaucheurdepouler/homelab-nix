{ appimageTools, fetchurl }:
let
  pname = "iloader";
  version = "1.1.6";

  src = fetchurl {
    url = "https://github.com/nab138/iloader/releases/download/v${version}/nuclear-linux-amd64.AppImage";
    hash = "sha256-L1fFwFjdIrrhviBlwORhSDXsNYgrT1NcVKAKlss6h4o=";
  };
in
appimageTools.wrapType2 { inherit pname version src; }
