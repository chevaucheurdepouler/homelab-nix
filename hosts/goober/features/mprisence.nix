{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.mprisence
  ];

  systemd.user.services.mprisence = {
    enable = true;
    wantedBy = "default.target";
    description = "Discord Rich Presence for MPRIS media players";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.mprisence}/bin/mprisence";
      Restart = "always";
      RestartSec = 10;
      Environment = [
        "RUST_LOG=info"
        "RUST_BACKTRACE=1"
      ];
      ReadWritePaths = [
        "%h/.config/mprisence"
        "%h/.cache/mprisence"
      ];
    };
  };

}
