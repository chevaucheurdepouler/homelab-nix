{
  pkgs,
  inputs,
  system,
  lib,
  ...
}:
{
  imports = [
    ../shared
  ];

  environment.systemPackages = [
    inputs.miovim.packages.${system}.default
    pkgs.curl
    pkgs.unzip
    pkgs.kitty.terminfo
    pkgs.foot.terminfo
    pkgs.kittysay
    pkgs.tmux
  ];

  environment.variables.EDITOR = "nvim";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

  services.tailscale.enable = true;

  # Set your time zone.
  time.timeZone = lib.mkDefault "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";

  # reducing disk usage
  boot.loader.systemd-boot.configurationLimit = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings.auto-optimise-store = true;
}
