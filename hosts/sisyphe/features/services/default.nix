{ config, ... }:
{
  imports = [
    # ./akkoma.nix
    ./archivebox.nix
    ./homelab-dashboard.nix
    ./nextcloud.nix
    # ./photoprism.nix
    # TODO: configure irc server correctly
    # ./irc-server.nix
    ./grafana.nix
    ./forgejo.nix
    # ./synapse-matrix.nix
    ./uptime-kuma.nix
  ];
}
