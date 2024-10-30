{ pkgs, config, ... }:
{
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    # hardware.opengl in 24.05
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.caddy.virtualHosts = {
      "http://jellyfin.sisyphe.normandy.hypervirtual.world".extraConfig = ''
        reverse_proxy :8096
      '';

      "http://media.hypervirtual.world".extraConfig = ''
        reverse_proxy :8096
      '';
  };
}
