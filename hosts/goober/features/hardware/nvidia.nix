{ config, pkgs, ... }:

{
  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = false;
  };
}
