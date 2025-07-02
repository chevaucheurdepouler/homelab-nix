{
  pkgs,
  inputs,
  system,
  lib,
  ...
}:
{

  imports = [
    ./ssh.nix
  ];
  environment.systemPackages = [
    pkgs.curl
    pkgs.unzip
    pkgs.kitty.terminfo
    pkgs.foot.terminfo
    pkgs.kittysay
    pkgs.tmux
    pkgs.fzf
  ];

  environment.variables.EDITOR = "nvim";
  programs.fzf.fuzzyCompletion = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  };

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
