{
  config,
  lib,
  pkgs,
  ...
}:
let
  ip = "192.168.1.177";
  gateway = "192.168.1.1";
  username = "homelab";
in
{
  imports = [
    ./features/containers/default.nix
    ./features/multimedia/default.nix
    ./features/databases/default.nix
    ./features/services/default.nix
    ./features/backups.nix
    ./features/caddy.nix
    ./features/prometheus.nix
    ./features/samba-shares.nix
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
        22 # ssh
        8008 # matrix-synapse
        8448 # matrix-synapse
        3030
        3333
        2344
        4000
        5050 # calibre-web
        9091 # transmission
      ];
      allowedUDPPorts = [ ];
    };
  };

  #TODO: setup fail2ban
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "192.168.1.0/24" ];
    extraPackages = [ ];
    jails = { };
  };

  users.groups.multimedia = {
    members = [
      "slskd"
      "radarr"
      "readarr"
      "sonarr"
      "transmission"
      "jellyfin"
      "bazarr"
      "calibre-web"
      username
    ];
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.defaultSopsFile = ./secrets/secrets.yaml;

  # define your secrets with 
  # `nix-shell -p sops --run "sops ./secrets/yoursecret.env"`

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
    bazarr
    ethtool
    networkd-dispatcher
    transcrypt
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services = {
    networkd-dispatcher = {
      enable = true;
      rules."50-tailscale" = {
        onState = [ "routable" ];
        script = ''
          ${pkgs.ethtool}/bin/ethtool -K ens18 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };
  };
}
