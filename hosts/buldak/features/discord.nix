{
  config,
  pkgs,
  inputs,
  ...
}:
let
  moonlight-client = pkgs.discord.override {
    withMoonlight = true;
    moonlight = inputs.moonlight.packages.${pkgs.system}.moonlight;
  };
in
{
  environment.systemPackages = with pkgs; [
    moonlight-client
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
