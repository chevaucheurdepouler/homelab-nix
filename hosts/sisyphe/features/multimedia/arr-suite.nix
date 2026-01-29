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
        url = "https://release-assets.githubusercontent.com/github-production-release-asset/90468352/a24880e7-d09c-43e9-9781-84fed1271c8f?sp=r&sv=2018-11-09&sr=b&spr=https&se=2026-01-29T18%3A27%3A37Z&rscd=attachment%3B+filename%3DLidarr.develop.3.1.2.4902.linux-core-x64.tar.gz&rsct=application%2Foctet-stream&skoid=96c2d410-5711-43a1-aedd-ab1947aa7ab0&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skt=2026-01-29T17%3A27%3A35Z&ske=2026-01-29T18%3A27%3A37Z&sks=b&skv=2018-11-09&sig=W5SCFNzmN1pAPrUc%2F8XSxGAYJMJaj98FrwVwDMjF8Mg%3D&jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmVsZWFzZS1hc3NldHMuZ2l0aHVidXNlcmNvbnRlbnQuY29tIiwia2V5Ijoia2V5MSIsImV4cCI6MTc2OTcxMTQ0OSwibmJmIjoxNzY5NzA3ODQ5LCJwYXRoIjoicmVsZWFzZWFzc2V0cHJvZHVjdGlvbi5ibG9iLmNvcmUud2luZG93cy5uZXQifQ.dI_RS3-sJR5xImC-GLFZNv36Kc7nwR38u_s3wiMLycE&response-content-disposition=attachment%3B%20filename%3DLidarr.develop.3.1.2.4902.linux-core-x64.tar.gz&response-content-type=application%2Foctet-stream";
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
