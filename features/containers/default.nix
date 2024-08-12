{ config, ... }:

{
  imports = [
    ./crafty-controller.nix
    ./flaresolverr.nix
    # ./freshrss.nix
    ./sonarr.nix
    #./pihole-exporter.nix
  ];
}
