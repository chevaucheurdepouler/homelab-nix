{
  config,
  lib,
  pkgs,
  ...
}:
let
  ip = "192.168.1.177";
  gateway = "192.168.1.1";
  driveMountPoint = "/srv/Multimedia";
  username = "homelab";
in
{
  imports = [
    ./features/authentik.nix
    ./features/slskd.nix
    ./features/arr-suite.nix
    ./features/samba-shares.nix
    ./features/containers.nix
    ./features/homelab-dashboard.nix
    ./features/transmission.nix
  ];

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
      username
    ];
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

  # define your secrets with 
  # `nix-shell -p sops --run "sops ./secrets/yoursecret.env"`

  sops.secrets."searx" = {
    sopsFile = ./secrets/searx.env;
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
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  # -arr suite

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
    virtualHosts.":80".extraConfig = ''
      reverse_proxy :8082
    '';

  };

  /*
    services.photoprism = {
      enable = true;
      settings = {
        PHOTOPRISM_DEFAULT_LOCALE = "fr";
      };
    };
  */

}
