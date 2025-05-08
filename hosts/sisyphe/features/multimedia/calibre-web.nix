{ config, ... }:

{
  services.calibre-web = {
    enable = true;
    openFirewall = true;
    listen.ip = "0.0.0.0";
    options = {
      enableBookUploading = true;
      enableKepubify = true;
    };
  };

  services.caddy.virtualHosts."http://books.rougebordeaux.xyz".extraConfig = ''
    reverse_proxy :8083
  '';
}
