{
  inputs,
  config,
  pkgs,
  ...
}:
let
  discord = pkgs.discord.override {
    withMoonlight = true;
    moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
  };
in
{
  environment.systemPackages = [
    discord
  ];
  # screen record support
  xdg = {
    autostart.enable = true;
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      wlr.enable = true;
    };
  };
}
