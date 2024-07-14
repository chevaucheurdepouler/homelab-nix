{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let

  ip = config.homelab-dashboard.defaultAddress;
in
{
  options = {
    homelab-dashboard.defaultAddress = mkOption { type = types.str; };
    homelab-dashboard.proxmoxVEIp = mkOption { type = types.str; };
    homelab-dashboard.proxmoxBSIp = mkOption { type = types.str; };
  };
  config = {
    services.homepage-dashboard = {
      enable = true;
      settings = {
        "headerStyle" = "boxed";
        "language" = "fr";
      };
      services = [
        {
          "Divertissement" = [
            {
              "Jellyfin" = {
                icon = "jellyfin";
                description = "Permet de regarder ou écouter du contenu.";
                href = "http://${ip}:8096/";
              };
            }
            {
              "Calibre-web" = {
                icon = "calibre";
                description = "Serveur de livres";
                href = "http://${ip}:8083";
              };
            }
          ];
        }
        {
          "Téléchargement" = [
            {
              "Jellyseerr" = {
                icon = "jellyseerr";
                description = "Moteur de recherche de films/séries";
                href = "http://${ip}:5055";
              };
            }
            {
              "slskd" = {
                icon = "slskd";
                description = "Pour télécharger/partager de la musique";
                href = "http://${ip}:5030";
              };
            }
            {
              "Readarr" = {
                icon = "readarr";
                description = "Moteur de recherche de livres";
                href = "http://${ip}:8787/";
              };
            }
            {
              "Prowlarr" = {
                icon = "prowlarr";
                description = "Indexe les différents sites de téléchargement";
                href = "http://${ip}:9696/";
              };
            }
            {

              "Sonarr" = {
                icon = "sonarr";
                description = "Moteur de recherche pour les séries";
                href = "http://${ip}:8989";
              };
            }
            {
              "Radarr" = {
                icon = "radarr";
                description = "Moteur de recherche pour les films";
                href = "http://${ip}:7878";
              };
            }
            {

              "Transmission" = {
                icon = "transmission";
                description = "s'occupe du téléchargement des fichiers";
                href = "http://${ip}:9091";
              };
            }
          ];
        }
        {
          "Utilitaires" = [
            {
              "Photoprism" = {
                icon = "photoprism";
                description = "Sauvegarde de photos";
                href = "http://${ip}:2342";
              };

            }
            {
              "Searx" = {
                icon = "searx";
                description = "Moteur de recherche privé pour remplacer Google.";
                href = "http://${ip}:8080";
              };
            }
          ];
        }
        {
          "Administration" = [
            {
              "Proxmox Backup Server" = {
                description = "Permet de sauvegarder le serveur.";
              };

            }
            {

              "Proxmox VE" = { };
            }
          ];
        }
      ];

    };
  };

}
