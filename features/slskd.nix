{ config, lib, ... }:
with lib;

let
  cfg = config.slskd;
in
{
  options = {
    slskd.directory = mkOption {
      type = types.str;
      default = "/srv/Multimedia/Music";
    };
  };
  config = {

    sops.secrets."slskd" = {
      sopsFile = ../secrets/slskd.env;
      format = "dotenv";
    };

    services.slskd = {
      enable = true;
      openFirewall = true;
      environmentFile = config.sops.secrets."slskd".path;
      domain = null;
      settings = {
        shares.directories = [ "${cfg.directory}" ];
        soulseek.description = "i luv katz n mewsik";
        directories.files.downloads = "${cfg.directory}/clean";
        directories.files.incomplete = "${cfg.directory}/incomplete";
      };
    };
  };
}
