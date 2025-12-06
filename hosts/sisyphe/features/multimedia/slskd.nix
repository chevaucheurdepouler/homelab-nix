{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
with lib;

let
  cfg = config.downloads.music;
in
{
  options = {
    downloads.music.directory = mkOption {
      type = types.str;
      default = "/srv/media/Music";
    };
  };
  config = {
    environment.systemPackages = with pkgs; [
      slskd
    ];

    sops.secrets.slskd = {
      sopsFile = "${secrets}/secrets/slskd.env";
      format = "dotenv";
    };

    services.slskd = {
      enable = true;
      openFirewall = true;
      environmentFile = config.sops.secrets.slskd.path;
      domain = null;
      settings = {
        shares.directories = [ "${cfg.directory}/clean" ];
        soulseek.description = "i wuv katz n mewsik!!! cantz red messages im dum kity : sen messag to missbehaves for replies!!";
        directories.downloads = "${cfg.directory}/downloads";
        directories.incomplete = "${cfg.directory}/incomplete";
      };
    };

    services.caddy.virtualHosts."http://slskd.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :5030
    '';
  };
}
