{ config, lib, ... }:
with lib;
let
  cfg = config.samba;
in
{
  options = {
    samba = {
      dir = mkOption {
        type = types.str;
        default = "/srv/Multimedia";
      };
    };
  };

  config = {
    services.samba = {
      enable = true;
      securityType = "user";
      openFirewall = true;
      settings = {
        global = {
          security = "user";
          "hosts allow" = "192.168.1. 127.0.0.1 localhost";
          "hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
        };
        "music" = {
          path = "/srv/media/Music";
          browseable = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        "ebooks" = {
          path = "${cfg.dir}/Ebooks";
          browseable = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
        };
        "movies" = {
          path = "${cfg.dir}/Films";
          browseable = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "read only" = "no";
        };
        "shows" = {
          path = "${cfg.dir}/SeriesTV";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          browseable = "yes";
        };
        "torrents" = {
          path = "${cfg.dir}/Torrents";
          "read only" = "yes";
          "create mask" = "644";
          browseable = "yes";
        };
      };
    };
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };


  services.avahi = {
    enable = true;
    publish.enable = true;
    publish.userServices = true;
    openFirewall = true;
  };
}
