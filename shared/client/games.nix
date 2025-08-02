{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];

    environment.systemPackages = with pkgs; [
      lutris
    ];
    systemd.extraConfig = "DefaultLimitNOFILE=524288";
    security.pam.loginLimits = [
      {
        domain = "misschloe777";
        type = "hard";
        item = "nofile";
        value = "524288";
      }
    ];
  };
}
