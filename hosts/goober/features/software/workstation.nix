{
  musnix,
  pkgs,
  lib,
  ...
}:
{
  # for java development on vscode
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "vscode"
      "tetrio-desktop"
      "beeper"
      "exact-audio-copy"
      "cider-2"
    ];
  fonts.fontDir.enable = true;
  environment.systemPackages = with pkgs; [
    zathura
    figma-linux
    cider-2
    libreoffice-qt
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-gb-large

    # video editing software
    #davinci-resolve

    # recording software
    obs-studio

    # drawing software
    krita

    # 3d modeling
    blender
    signal-desktop
    gajim
    weechat

    gvfs

    nil
    bitwarden-desktop
    ente-web
    exactaudiocopy
    picard
    i2pd
    nicotine-plus
    mpd
    mpdas

    # games
    tetrio-desktop
    osu-lazer-bin
    esptool
  ];

  services.mpdscribble = {
    enable = true;
    endpoints = {
      "last.fm" = {
        passwordFile = "/run/secrets/lastfm_password";
        username = "ariburnznfire";
      };
    };
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
