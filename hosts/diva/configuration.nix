{ inputs, ... }:
{
  imports = [ ./features ];
  networking.hostName = "diva"; # Define your hostname.

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # ssh
      80 # http
      443 # ssl
    ];
  };

  # reducing disk usage
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  nix.settings.auto-optimise-store = true;
  services.caddy.enable = true;
}
