{ config, pkgs, ... }:
{
  imports = [
    ./containers
    ./multimedia
    ./databases
    ./services
    ./backups.nix
    ./caddy.nix
    ./prometheus.nix
    ./samba-shares.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    transmission
    homepage-dashboard
    ethtool
    networkd-dispatcher
    transcrypt
    libressl_3_9
  ];
}
