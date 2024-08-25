# TODO: move file to configuration.nix
{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
let
  ip = "192.168.1.177";
  gateway = "192.168.1.1";
  username = "homelab";
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
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];

    nftables.enable = true;
    # firewall rules
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # ssh
        80 # http
        8008 # matrix-synapse
        8448 # matrix-synapse
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
      "bazarr"
      "calibre-web"
      username
    ];
  };

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.defaultSopsFile = "${secrets}/secrets/secrets.yaml";
}
