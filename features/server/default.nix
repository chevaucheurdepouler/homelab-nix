{ config, pkgs, ... }:
{
  imports = [
    ./containers/default.nix
    ./multimedia/default.nix
    ./databases/default.nix
    ./services/default.nix
    ./backups.nix
    ./caddy.nix
    ./prometheus.nix
    ./samba-shares.nix
    ./ssh.nix
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
  ];
}
