{ pkgs, lib, ... }:
{
  # for java development on vscode
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
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
    davinci-resolve

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
    xfce.thunar

    eclipses.eclipse-java # school wants us to use it...
    nil
    jetbrains.idea-ultimate
  ];
}
