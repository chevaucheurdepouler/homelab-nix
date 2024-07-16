{
  config,
  pkgs,
  lib,
  ...
}:
with lib;

let
  cfg = config.arrSuite;
in
{
  services.sonarr = {
    enable = true;
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
    openFirewall = true;
  };

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
}
