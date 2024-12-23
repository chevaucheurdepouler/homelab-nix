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
      extraConfig = ''
        workgroup = WORKGROUP
        server string = hyperserver
        netbios name = hyperserver
        security = user
      '';
      shares = {
        music = {
          path = "/srv/media/Music";
          browseable = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0655";
        };
        ebooks = {
          path = "${cfg.dir}/Ebooks";
          browseable = "yes";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0655";
        };
        movies = {
          path = "${cfg.dir}/Films";
          browseable = "yes";
          "create mask" = "0644";
          "directory mask" = "0655";
          "read only" = "no";
        };
        shows = {
          path = "${cfg.dir}/SeriesTV";
          "read only" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          browseable = "yes";
        };
        torrents = {
          path = "${cfg.dir}/Torrents";
          "read only" = "yes";
          "create mask" = "644";
          browseable = "yes";
        };
      };
    };
  };

}
