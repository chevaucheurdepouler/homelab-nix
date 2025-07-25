{
  config,
  pkgs,
  inputs,
  ...
}:
let
  moonlight-client = pkgs.discord.override {
    withMoonlight = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    moonlight-client
    inputs.moonlight.packages.${pkgs.system}.moonlight
    vesktop
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
