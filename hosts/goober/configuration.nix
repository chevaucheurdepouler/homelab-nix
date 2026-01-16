{
  config,
  lib,
  username,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../shared/client/tailscale.nix
    ../../shared/client/niri.nix
    ../../shared/client/nh.nix
    ../../shared/fonts.nix
    ./features/default.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };

    plymouth = {
      enable = true;
      # theme = "catppuccin-mocha";
      # themePackages = [
      #   pkgs.catppuccin-plymouth
      # ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  networking.nameservers = [
    "80.67.169.12" # https://www.fdn.fr/actions/dns/
    "80.67.169.40"
    "2001:910:800::12"
    "2001:910:800::40"
  ];

  nixpkgs.config.allowUnfree = true;
  time.hardwareClockInLocalTime = true;

  networking.hostName = "goober"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.firewall.allowedTCPPorts = [ 2234 ];

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
    #   useXkbConfig = true; # use xkb.options in tty.
  };

  # mount compression
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    #"/swap".options = ["compress=zstd"];
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Configure keymap in X11
  services.xserver.xkb.layout = "fr";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "networkmanager"
      "podman"
      "dialout"
      "gamemode"
    ];

    packages = with pkgs; [
      inputs.zen-browser.packages."${system}".default
      tailscale
      mpv
      logisim-evolution
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    mprisence
    dnsutils
    whois
    dwl
    git
    tmux
    mako
    grim
    slurp
    wl-clipboard
    udiskie
    lutris
    networkmanagerapplet
    gnome-mines
    gnome-disk-utility
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.udisks2.enable = true;

  security.pam.services.swaylock = { };

  # cleaning old builds
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  documentation.dev.enable = true;
  systemd.settings.Manager = {
    "DefaultLimitNOFILE" = "524288";
  };
  security.pam.loginLimits = [
    {
      domain = "misschloe777";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    openFirewall = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  fonts.fontconfig.defaultFonts.emoji = [
    "Noto Color Emoji"
  ];
  fonts.enableDefaultPackages = true;
  fonts.fontconfig.useEmbeddedBitmaps = true;
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
