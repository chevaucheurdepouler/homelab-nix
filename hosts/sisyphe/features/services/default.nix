{ config, ... }:
{
  imports = [
    # ./akkoma.nix
    ./homelab-dashboard.nix
    ./nextcloud.nix
    # ./photoprism.nix
    ./irc-server.nix
    ./grafana.nix
    ./forgejo.nix
    # ./synapse-matrix.nix
    ./uptime-kuma.nix
  ];
}
