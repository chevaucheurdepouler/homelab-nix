{config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mako
    grim
    slurp
    wl-clipboard
    xdg-utils
    sway-contrib.grimshot
    swaylock
    swaynotificationcenter
  ];

  services.gnome.gnome-keyring.enable = true;
  programs.sway = { 
    enable = true;
    wrapperFeatures.gtk = true;
  };

  xdg.portal.wlr.enable = true;
  security.pam.loginLimits = [
  { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
];

  }
