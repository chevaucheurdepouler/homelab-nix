{ config, ... }:
{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "192.168.1.0/24" ];
    extraPackages = [ ];
    jails = { };
  };
}
