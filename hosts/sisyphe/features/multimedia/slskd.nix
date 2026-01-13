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
      domain = "slskd.bzh.rougebordeaux.xyz";
      settings = {
        instance_name = "kitten";
        metrics = {
          enabled = true;
          url = "/metrics";
        };
        shares.directories = [ "${cfg.directory}/clean" ];
        soulseek.description = "bass slut since 2003!";
        directories.downloads = "${cfg.directory}/downloads";
        directories.incomplete = "${cfg.directory}/incomplete";
        permissions.file.mode = 664;
      };
    };

    services.caddy.virtualHosts."http://slskd.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :5030
    '';
  };
}
