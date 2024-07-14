{ config, lib }:
with lib;

let
  cfg = config.slskd;
in
{
  options = {
    slskd.directory = mkOption { type = types.str; };
  };
  config = {

    sops.secrets."slskd" = {
      sopsFile = ./secrets/slskd.env;
      format = "dotenv";
    };
    services.slskd = {
      enable = true;
      openFirewall = true;
      environmentFile = config.sops.secrets."slskd".path;
      domain = null;
      settings = {
        shares.directories = [ "${cfg.slskd.directory}/Music" ];
        soulseek.description = "i luv katz n mewsik";
        directories.files.downloads = "${cfg.slskd.directory}/Music/clean";
        directories.files.incomplete = "${cfg.slskd.directory}/Music/incomplete";
      };
    };
  };
}
