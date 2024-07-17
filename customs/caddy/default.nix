let
  pkgs = import <nixpkgs> { };

in
{
  name = "caddy";
  buildInputs = with pkgs; [
    xcaddy
    go
  ];
}
