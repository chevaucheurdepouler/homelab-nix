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
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    transmission
    sonarr
    radarr
    prowlarr
    readarr
    jellyseerr
    homepage-dashboard
    slskd
    bazarr
    ethtool
    networkd-dispatcher
    transcrypt
    libressl_3_9
  ];
}
