{ pkgs, ... }:
{
  services.mealie = {
    enable = true;
    database.createLocally = true;
    settings = { };
  };

  networking.firewall.allowedTCPPorts = [ 9000 ];
}
