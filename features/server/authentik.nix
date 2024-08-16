{ config, ... }:
let
  authentik-version = "2024.6.1";
  authentik-nix-src = builtins.fetchTarball {
    url = "https://github.com/nix-community/authentik-nix/archive/version/${authentik-version}.tar.gz";
    sha256 = "10ss29nzifyrq44080mjqa6xl6qw9mz755xcrla3kjxjl7d0mvlz";
  };
  authentik-nix = import authentik-nix-src;
  cfg = config.authentik;
in
{
  imports = [ authentik-nix.nixosModules.default ];
  sops.secrets."authentik" = {
    sopsFile = ../secrets/authentik.env;
    format = "dotenv";
  };

  /*
    sops.secrets.mail-server = {
      sopsFile = ./secrets/mail.json;
      format = "json";
    };
  */

  services.authentik = {
    enable = true;
    environmentFile = config.sops.secrets."authentik".path;
    settings = {
      /*
        email = {
          host = config.sops.secrets.mail-server."host";
          username = config.sops.secrets.mail-server."username";
        };
      */

      disable_startup_analytics = true;
      avatars = "initials";
    };
  };
}
