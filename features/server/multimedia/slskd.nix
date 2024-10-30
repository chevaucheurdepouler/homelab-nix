{
  config,
  lib,
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
        soulseek.description = "i luv katz n mewsik";
        directories.downloads = "${cfg.directory}/downloads";
        directories.incomplete = "${cfg.directory}/incomplete";
      };
    };

    services.caddy.virtualHosts."http://slskd.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :5030
      '';
  };
}
