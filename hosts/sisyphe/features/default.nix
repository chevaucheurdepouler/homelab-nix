{ config, pkgs, ... }:
{
  imports = [
    ./containers
    ./multimedia
    ./databases
    ./services
    ./auth
    ./backups.nix
    ./caddy.nix
    ./prometheus.nix
    ./samba-shares.nix
    ./tailscale.nix
    # ./bitmagnet.nix
  ];
}
