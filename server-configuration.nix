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
    ./features/arr-suite.nix
    ./features/authentik.nix
    ./features/calibre-web.nix
    ./features/containers.nix
    ./features/freshrss.nix
    ./features/grafana.nix
    ./features/homelab-dashboard.nix
    ./features/samba-shares.nix
    ./features/searx.nix
    # ./features/synapse-matrix.nix
    ./features/slskd.nix
    ./features/transmission.nix
    ./features/uptime-kuma.nix
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
        3000 # grafana
        4000 # uptime-kuma
        5030 # slskd
        8080 # searxng
        8083 # calibre-web
        8443 # crafty-controller
        9000 # authentik
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
      username
    ];
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;

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
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.caddy = {
    enable = true;
    virtualHosts.":80".extraConfig = ''
      reverse_proxy :8082
    '';

    virtualHosts.":3001".extraConfig = ''
      reverse_proxy :3000
    '';
    virtualHosts.":4001".extraConfig = ''
      reverse_proxy :4000
    '';
  };
}
