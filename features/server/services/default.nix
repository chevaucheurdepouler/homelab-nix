{ config, ... }:
{
  imports = [
    ./homelab-dashboard.nix
    ./nextcloud.nix
    # ./photoprism.nix
    ./grafana.nix
    ./forgejo.nix
    ./synapse-matrix.nix
    ./uptime-kuma.nix
  ];
}
