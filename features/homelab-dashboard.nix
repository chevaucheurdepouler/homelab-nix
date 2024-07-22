{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.homepage-dashboard;
  ip = cfg.baseURL;
in
{
  options = {
    homepage-dashboard.baseURL = mkOption {
      type = types.str;
      default = "192.168.1.177";
    };
    homepage-dashboard.proxmoxVEIp = mkOption {
      type = types.str;
      default = "192.168.1.10";
    };
    homepage-dashboard.proxmoxBSIp = mkOption {
      type = types.str;
      default = "";
    };
    homepage-dashboard.piholeURL = mkOption {
      type = types.str;
      default = "192.168.1.25";
    };
  };

  #TODO: add Radarr/Sonarr/... api key support
  config = {
    sops.secrets."homepage" = {
      sopsFile = ../secrets/homepage.env;
      format = "dotenv";
    };

    services.homepage-dashboard = {
      enable = true;
      environmentFile = config.sops.secrets."homepage".path;
      settings = {
        headerStyle = "boxed";
        language = "fr";
        title = "sillybox home !!";
        layout = [
          {
            "Vidéos & Séries" = {
              style = "row";
              columns = 4;
            };
          }
          {
            "Administration" = {
              style = "row";
              columns = 4;
            };
          }
        ];
      };
      widgets = [
        {
          resources = {
            cpu = true;
            disk = "/";
            memory = true;
          };
        }
        {
          search = {
            provider = "duckduckgo";
            target = "_blank";
          };
        }
      ];

      bookmarks = [ { code = [ { "Github" = [ { href = "https://github.com"; } ]; } ]; } ];

      services = [
        {
          "Divertissement" = [

            {
              "Serveur Minecraft poulet" = {
                icon = "minecraft";
                description = "serveur des trois poulets";
                widget = {
                  type = "minecraft";
                  url = "udp://${ip}:25565";
                };
              };
            }
            {
              "Crafty-controller" = {
                description = "Gestionnaire de serveur Minecraft";
                href = "https://192.168.1.177:8443";
              };
            }
          ];
        }
        {
          "Lecture" = [
            {
              "Calibre-web" = {
                icon = "calibre";
                description = "Serveur de livres";
                href = "http://${ip}:5050";
              };
            }
            {
              "Freshrss" = {
                icon = "freshrss";
                description = "Récupère les articles";

              };
            }
          ];
        }
        {
          "Vidéos & Séries" = [
            {

              "Jellyfin" = {
                icon = "jellyfin";
                description = "Permet de regarder ou écouter du contenu.";
                href = "http://${ip}:8096";
                widget = {
                  type = "jellyfin";
                  url = "http://${ip}:8096";
                  enableBlocks = true;
                  key = "{{HOMEPAGE_VAR_JELLYFIN}}";
                };
              };
            }
            {
              "Jellyseerr" = {
                icon = "jellyseerr";
                description = "Moteur de recherche de films/séries";
                href = "http://${ip}:5055";

                widget = {
                  type = "jellyseerr";
                  url = "http://${ip}:5055";
                  key = "{{HOMEPAGE_VAR_JELLYSEERR}}";
                };
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
              "Prowlarr" = {
                icon = "prowlarr";
                description = "Indexe les différents sites de téléchargement";
                href = "http://${ip}:9696/";
                widget = {
                  type = "prowlarr";
                  key = "{{HOMEPAGE_VAR_PROWLARR}}";
                  url = "http://${ip}:9696";
                };
              };
            }
            {
              "Sonarr" = {
                icon = "sonarr";
                description = "Moteur de recherche pour les séries";
                href = "http://${ip}:8989/";
                widget = {
                  type = "sonarr";
                  url = "http://${ip}:8989";
                  key = "{{HOMEPAGE_VAR_SONARR}}";
                };
              };
            }
            {
              "Radarr" = {
                icon = "radarr";
                description = "Moteur de recherche pour les films";
                href = "http://${ip}:7878";
                widget = {
                  type = "radarr";
                  key = "{{HOMEPAGE_VAR_RADARR}}";
                  url = "http://${ip}:7878";
                };
              };
            }
            {
              "Bazarr" = {
                icon = "bazarr";
                description = "Vérifie les sous titres des films/séries.";
                href = "http://${ip}:6767";
                widget = {
                  type = "bazarr";
                  key = "{{HOMEPAGE_VAR_BAZARR}}";
                  url = "http://${ip}:6767";
                };
              };
            }
            {

              "Transmission" = {
                icon = "transmission";
                description = "s'occupe du téléchargement des fichiers";
                href = "http://${ip}:9091";
                widget = {
                  type = "transmission";
                  url = "http://${ip}:9091";
                  username = "{{HOMEPAGE_VAR_TRANSMISSIONUSERNAME}}";
                  password = "{{HOMEPAGE_VAR_TRANSMISSIONPASSWORD}}";
                };
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
            /*
              {
                "Proxmox Backup Server" = {
                  icon = "proxmox-light";
                  description = "Permet de sauvegarder le serveur.";
                  href = "https://${cfg.proxmoxBSIp}:8007";
                };
              }
            */
            {
              "Proxmox VE" = {
                icon = "proxmox";
                description = "Panneau de controle des machines virtuelles";
                href = "https://${cfg.proxmoxVEIp}:8006";
                widget = {
                  type = "proxmox";
                  username = "{{HOMEPAGE_VAR_PROXMOXUSERNAME}}";
                  password = "{{HOMEPAGE_VAR_PROXMOXPASSWORD}}";
                  url = "https://${cfg.proxmoxVEIp}:8006";
                  node = "pve";
                };
              };
            }
            {
              "Pi.hole" = {
                icon = "pi-hole";
                description = "Bloqueur de pubs DNS/DHCP";
                href = "http://${cfg.piholeURL}/admin";
                widget = {
                  type = "pihole";
                  key = "{{HOMEPAGE_VAR_PIHOLE}}";
                  url = "http://${cfg.piholeURL}";
                };
              };
            }
            {
              "Grafana" = {
                icon = "grafana";
                description = "Visualiseur de graphiques";
                href = "http://${ip}:3001";
              };
            }
            {
              "InfluxDB" = {
                icon = "influxdb";
                description = "Traite les statistiques du serveur Proxmox";
                href = "http://192.168.1.157:8086";
              };
            }
            {
              "Uptime Kuma" = {
                icon = "uptime-kuma";
                description = "Surveille l'état des différents services";
                href = "http://${ip}:4001";
              };
            }
            {
              "Uptime Robot" = {
                icon = "uptime-kuma";
                description = "Surveille l'état des sites (hors réseau maison)";
                widget = {
                  type = "uptimerobot";
                  url = "https://api.uptimerobot.com";
                  key = "{{HOMEPAGE_VAR_UPTIMEROBOT}}";
                };
              };
            }
          ];
        }
      ];

    };
  };
}
