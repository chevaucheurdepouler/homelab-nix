{ config, ... }:
{
  imports = [
    ./backups.nix
    ./fail2ban.nix
    # ./nextcloud.nix
    ./uptime-kuma.nix
  ];
}
