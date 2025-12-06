{ pkgs, config, ... }:
{
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

  ];

  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
      intel-media-driver
      intel-compute-runtime-legacy1 # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # or i965 for older GPUs
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  services.caddy.virtualHosts = {
    "http://jellyfin.sisyphe.bzh.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8096
    '';

    "http://media.rougebordeaux.xyz".extraConfig = ''
      reverse_proxy :8096
    '';
  };
}
