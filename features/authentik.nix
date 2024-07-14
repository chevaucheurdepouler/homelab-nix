{ config, ... }:
let
  authentik-version = "2024.6.1";
  authentik-nix-src = builtins.fetchTarball {
    url = "https://github.com/nix-community/authentik-nix/archive/version/${authentik-version}.tar.gz";
    sha256 = "15b9a2csd2m3vwhj3xc24nrqnj1hal60jrd69splln0ynbnd9ki4";
  };
  authentik-nix = import authentik-nix-src;
in
{

  imports = [ authentik-nix.nixosModules.default ];

  sops.secrets."authentik" = {
    sopsFile = ./secrets/authentik.env;
    format = "dotenv";
  };

  services.authentik = {
    enable = true;
    environmentFile = config.sops.secrets."authentik".path;
    settings = {
      email = {

      };

      disable_startup_analytics = true;

      avatars = "initials";
    };
  };
}
