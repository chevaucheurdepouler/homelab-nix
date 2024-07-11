{
  config,
  lib,
  pkgs,
  ...
}:
let
  ip = "192.168.1.207";
  gateway = "192.168.1.1";
  driveMountPoint = "/mnt/hdd1";
  authentik-version = "2024.2.3";
  authentik-nix-src = builtins.fetchTarball {
    url = "https://github.com/nix-community/authentik-nix/archive/version/${authentik-version}.tar.gz";
    sha256 = "15b9a2csd2m3vwhj3xc24nrqnj1hal60jrd69splln0ynbnd9ki4";
  };
  authentik-nix = import authentik-nix-src;
in
{
  # setting up networking!!
  networking = {
    interfaces = {
      ens18.ipv4.addresses = [
        {
          address = ip;
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = gateway;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    nftables.enable = true;
    # firewall rules
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        5030
        8080
        9091
      ];
      allowedUDPPorts = [ ];
    };
  };

  users.groups.multimedia = {
    members = [
      "slskd"
      "radarr"
      "readarr"
      "sonarr"
      "transmission"
      "jellyfin"
      "cypherpunk"
    ];
  };

  # enable samba
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = hyperserver
      netbios name = hyperserver
      security = user
    '';
    shares = {
      music = {
        path = "${driveMountPoint}/Musique";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "cypherpunk";
      };
      ebooks = {
        path = "${driveMountPoint}/Ebooks";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "cypherpunk";
      };
    };
  };

  imports = [ authentik-nix.nixosModules.default ];

  sops.age.sshKeyPaths = [ "/home/cypherpunk/.ssh/id_ed25519" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

  # define your secrets with 
  # `nix-shell -p sops --run "sops ./secrets/yoursecret.env"`

  sops.secrets."searx" = {
    sopsFile = ./secrets/searx.env;
    format = "dotenv";
  };

  sops.secrets."slskd" = {
    sopsFile = ./secrets/slskd.env;
    format = "dotenv";
  };

  sops.secrets."authentik" = {
    sopsFile = ./secrets/authentik.env;
    format = "dotenv";
    disable_startup_analytics = true;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    transmission
    sonarr
    radarr
    prowlarr
    readarr
    jellyseerr
    homepage-dashboard
    slskd
    niv # for using sops-nix
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "cypherpunk";
  };

  # -arr suite
  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  services.radarr = {
    enable = true;
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

  # torrenting apps
  services.transmission = {
    enable = true;
    openFirewall = true;
    openRPCPort = true;
    credentialsFile = "";
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist-enabled = false;
      rpc-authentication-required = true;
      download-dir = "${driveMountPoint}/Torrents";
      ratio-limit-enabled = true;
    };
  };

  services.slskd = {
    enable = true;
    openFirewall = true;
    environmentFile = config.sops.secrets."slskd".path;
    domain = null;
    settings = {
      shares.directories = [ "${driveMountPoint}/Music" ];
      soulseek.description = "i luv katz n mewsik";
      directories.files.downloads = "${driveMountPoint}/Music/clean";
      directories.files.incomplete = "${driveMountPoint}/Music/incomplete";
    };
  };

  services.searx = {
    enable = true;
    settings = {
      server.secret_key = builtins.toJSON config.sops.secrets."searx";
    };
  };

  services.calibre-web = {
    enable = true;
    openFirewall = true;
    options = {
      enableBookUploading = true;
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      reverse_proxy :8082
    '';
  };

  /*
    services.authentik = {
      enable = true;
      environmentFile = config.sops.secrets."authentik".path;
    };

    services.photoprism = {
        enable = true;
        settings = {
          PHOTOPRISM_DEFAULT_LOCALE = "fr";
        };
      };
  */

  # docker containers, for apps that aren't avaiable on Nix.  (yet)
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      flaresolverr = {
        ports = [ "8181:8181" ];
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
        environment = {
          "LOG_LEVEL" = "info";
        };
      };
      crafty-controller = {
        image = "registry.gitlab.com/crafty-controller/crafty-4:latest";
        ports = [
          "8443:8443"
          "8123:8123"
          "19132:19132/udp"
          "25500-25600:25500-25600"
        ];
        volumes = [ ];
        environment = {
          "TZ" = "Europe/Paris";
        };
      };
    };
  };

  services.homepage-dashboard = {
    enable = true;
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
            "calibre-web" = {
              icon = "Calibre";
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
              icon = "Jellyseerr";
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
        ];
      }
    ];

  };
}
