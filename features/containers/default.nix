{ config, ... }:

{
  imports = [
    ./crafty-controller.nix
    ./flaresolverr.nix
    ./freshrss.nix
  ];
}
