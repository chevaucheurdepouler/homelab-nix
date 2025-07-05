{ pkgs, lib, ... }:
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
    ];

  environment.systemPackages = with pkgs; [
    zathura
    # music editing software
    reaper

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

    beeper
    signal-desktop
    gajim
    weechat

    gvfs
    xfce.thunar

    eclipses.eclipse-java # school wants us to use it...
    nil
    jetbrains.idea-ultimate

    # why3
    # alt-ergo
    # cvc4
    # z3
    bitwarden
    kicad
    ente-auth
    ente-web
    jetbrains.rider
    revolt-desktop
    exactaudiocopy
    picard
    nextcloud-client
    i2pd
    nicotine-plus
    mpd
    mpdas

    # games
    tetrio-desktop
    osu-lazer-bin
  ];

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
