{ config, lib, ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "http://mc.bzh.rougebordeaux.xyz".extraConfig = ''
        reverse_proxy :8443
      '';
    };
  };

}
