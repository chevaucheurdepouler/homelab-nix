{ config, pkgs, ... }:
{
  imports = [
    ./nh.nix
    ./tailscale.nix
  ];
}
