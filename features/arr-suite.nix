{ pkgs }:
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

  services.readarr = {
    enable = true;
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

  systemd.services.sonarrAnime = {
    enable = true;
    path = [ pkgs.sonarr ];
    serviceConfig = {
      ExecStart = "Sonarr -nobrowser -data=/var/lib/sonarrAnime";
    };
  };
}
