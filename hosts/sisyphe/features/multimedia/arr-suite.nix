{
  config,
  pkgs,
  lib,

  ...
}:

let
  cfg = config.arrSuite;
  lidarr-nightly = pkgs.lidarr.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "3.1.2.4902";
      src = builtins.fetchurl {
        url = "http://lidarr.servarr.com/v1/update/develop/updatefile?os=linux&runtime=netcore&arch=x64";
        sha256 = "sha256-1oSFJtQ9/ICACFBFgp2kPzfP0dKitMg7vqAN7iT0KTA=";
      };
    }
  );
in
{
  environment.systemPackages = with pkgs; [
    sonarr
    radarr
    prowlarr
    jellyseerr
    bazarr
    lidarr
  ];

  services.lidarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
    package = lidarr-nightly;
  };

  services.sonarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.jellyseerr = {
    openFirewall = true;
    enable = true;
  };

  services.bazarr = {
    enable = true;
    group = "multimedia";
    openFirewall = true;
  };
  /*
      #TODO: create duplicated instances of Sonarr.
      systemd.services."sonarrAnime" = {
        enable = true;
        description = "Duplicated Sonarr instance, for animes";
        after = [
          "syslog.target"
          "network.target"
        ];

        path = [ pkgs.sonarr ];
        serviceConfig = {
          Type = "simple";
          User = "sonarr";
          ExecStart = "${pkgs.sonarr}/bin/Sonarr -nobrowser -data=/var/lib/sonarrAnime";
          TimeoutStopSec = "20";
          KillMode = "process";
          Restart = "on-failure";
        };
        wantedBy = [ "multi-user.target" ];
      };
  */

  services.caddy.virtualHosts = {
    "http://radarr.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :7878
    '';

    "http://sonarr.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8989
    '';

    "http://sonarr-anime.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8999
    '';

    "http://prowlarr.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :9696
    '';

    "http://katflix.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :5055
    '';

    "http://bazarr.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :6767
    '';

    "http://bazarr-anime.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :6777
    '';
  };
}
