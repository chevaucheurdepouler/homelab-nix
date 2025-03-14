{ pkgs, lib, ... }:
{

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "reaper"
      "davinci-resolve"
    ];
  environment.systemPackages = with pkgs; [
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
  ];
}
