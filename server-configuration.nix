{
  config,
  lib,
  pkgs,
  ...
}:
let
  ip = "192.168.1.207";
  driveMountPoint = "/mnt/hdd1";
  authentik-version = "2024.2.3";
  authentik-nix-src = builtins.fetchTarball {
    url = "https://github.com/nix-community/authentik-nix/archive/version/${authentik-version}.tar.gz";
    sha256 = "15b9a2csd2m3vwhj3xc24nrqnj1hal60jrd69splln0ynbnd9ki4";
  };
  authentik-nix = import authentik-nix-src;
in
{
  # mounting external hard drives !
  fileSystems."/mnt/hdd1" = {
    device = "/dev/disk/by-uuid/008e5b16-5620-4fd5-a506-ef8d9bdec0c7";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "rw"
    ];
  };

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

    defaultGateway = "192.168.1.1";
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    nftables.enable = true;
    # firewall rules
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 5030 8080 9091 ];
      allowedUDPPorts = [ ];
    };
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
        path = "${driveMountPoint}/Music";
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

  sops.secrets."searx.env" = { 
    sopsFile = ./secrets/searx.env;
    format = "dotenv";
  };

  sops.secrets."slskd.env" = {
    sopsFile = ./secrets/slskd.env;
    format = "dotenv";
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

  services.slskd = {
    enable = true;
    openFirewall = true;
    environmentFile = config.sops.secrets."slskd.env".path;
    domain = null;
    settings = {
      shares.directories = [ "${driveMountPoint}/Music" ];
      soulseek.description = "i luv katz n mewsik";
      directories.files.downloads = "${driveMountPoint}/Music/clean";
      directories.files.incomplete = "${driveMountPoint}/Music/incomplete";
    };
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  services.jellyseerr = {
    openFirewall = true;
    enable = true;
  };

  services.transmission = {
    enable = true;
    openFirewall = true;
    openRPCPort = true;
    settings = {
      rpc-bind-address = "0.0.0.0"; #Bind to own IP
      rpc-whitelist-enabled = false;
      download-dir = "${driveMountPoint}/Torrents";
    };
  };

  services.searx = {
    enable = true;
    settings = {
      server.secret_key = builtins.toJSON config.sops.secrets."searx.env";
    };
  };

  services.calibre-web = {
    enable = true;
    openFirewall = true;
    options = {
      enableBookUploading = true;
    };
  };

  /*
    services.authentik = {
      enable = true;
    };

      services.photoprism = {

        enable = true;
        originalsPath = "/mnt/hdd1/photoprism";
        settings = {
          PHOTOPRISM_DEFAULT_LOCALE = "fr";
        };
      };
  */

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      flaresolverr = {
        ports = [ "8181:8181" ];
        image = "ghcr.io/flaresolverr/flaresolverr:latest";
	environment = {};
      };
    };
};

  services.homepage-dashboard = {
    enable = true;
    openFirewall = true;
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
              description = "Pour télécharger/partager de la musique";
              href = "http://${ip}:5030";
            };
          }
          {
            "Readarr" = {
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

  };

