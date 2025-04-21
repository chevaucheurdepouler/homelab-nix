{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
    grim
    slurp
    wl-clipboard
    xdg-utils
    sway-contrib.grimshot
    swaylock
    swaynotificationcenter
    nautilus
    libheif
    libheif.out
    xwayland-satellite
  ];

  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.niri = {
    enable = true;
  };

  xdg.portal = {
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.xserver.displayManager.gdm.enable = true;

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nautilus = prev.nautilus.overrideAttrs (nprev: {
        buildInputs =
          nprev.buildInputs
          ++ (with pkgs.gst_all_1; [
            gst-plugins-good
            gst-plugins-bad
          ]);
      });
    })
  ];

  services.xserver.xkb = {
    layout = "fr";
  };

  programs.waybar = {
    enable = true;
  };
}
