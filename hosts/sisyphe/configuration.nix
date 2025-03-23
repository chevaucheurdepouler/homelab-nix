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
  imports = [
    ./hardware-configuration.nix
    ./features
    ../shared
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.kernelParams = [ "console=ttyS0" ];

  services.qemuGuest.enable = true;
  networking.hostName = "sisyphe"; # Define your hostname.

  users.users.homelab = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "dialout"
      "docker"
    ];

    packages = with pkgs; [
      btop
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8sdToNavEQv7PTMJ97HIGM6UlChwGS3x9O8hFilzui harryh@ik.me"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHjz5MUSmc1ahtUJWuvzG7PHH432nx6a0Nj2zfxt3oTP geekcat@protonmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP9Yp7TbDhYJ27Sh+LcPXT569bMVwbFrkE4zksfU84l+ harry123@goober"
    ];

    initialHashedPassword = "$y$j9T$H0D6NpMw1EU.oDhbMWrwL.$wDGGBKKGQdzeDRTzq0gWhoLdyUpQ2w6PMmGl.nuQ11/";
  };

  users.users.root.initialHashedPassword = "$y$j9T$99/NEnBGoewbrl5eHvTw7/$87rjPrvqs0Ys72338SxZJDibi8p7Fe8Can37rJyhcQ.";

  environment.systemPackages = with pkgs; [
    git
    neovim
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
        443 # ssh
        8080
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

  # sonarr needs some EoL packages to be build
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  # seems like sabnzbd needs some unfree pkgs...
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "unrar"
    ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
