{
  inputs,
  config,
  pkgs,
  ...
}:
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
    inputs.swww.packages.${pkgs.system}.swww
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

  services.displayManager.gdm.enable = true;
  services.udisks2.enable = true;

  security.pam.services.swaylock = { };
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
