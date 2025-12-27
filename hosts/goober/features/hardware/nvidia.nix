{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mesa-demos
  ];

  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;
}
