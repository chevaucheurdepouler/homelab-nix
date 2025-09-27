{ config, pkgs, ... }:
{
  imports = [
    ./nh.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
  ];
}
