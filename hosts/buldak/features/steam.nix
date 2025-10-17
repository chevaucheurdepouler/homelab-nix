{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "steam-run"
    ];
  systemd.settings.Manager = {
    "DefaultLimitNOFILE" = 524288;
  };
  security.pam.loginLimits = [
    {
      domain = "misschloe777";
      type = "hard";
      item = "nofile";
      value = "524288";
    }
  ];
  environment.systemPackages = with pkgs; [
    lutris
  ];
}
