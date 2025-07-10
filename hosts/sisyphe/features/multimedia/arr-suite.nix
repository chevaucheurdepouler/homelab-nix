{
  config,
  pkgs,
  ...
}:

let
  cfg = config.arrSuite;
in
{
  environment.systemPackages = with pkgs; [
    sonarr
    radarr
    prowlarr
    jellyseerr
    bazarr
  ];
  /*
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
    "http://radarr.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :7878
    '';

    "http://sonarr.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8989
    '';

    "http://sonarr-anime.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8999
    '';

    "http://prowlarr.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :9696
    '';

    "http://katflix.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :5055
    '';

    "http://bazarr.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :6767
    '';

    "http://bazarr-anime.sisyphe.normandy.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :6777
    '';
  };
}
