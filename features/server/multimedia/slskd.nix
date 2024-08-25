{ config, lib, ... }:
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
      sopsFile = ../../../secrets/slskd.env;
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
        directories.files.downloads = "${cfg.directory}/downloads";
        directories.files.incomplete = "${cfg.directory}/incomplete";
      };
    };
  };
}
