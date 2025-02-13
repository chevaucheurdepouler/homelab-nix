{config, pkgs, ...}:

{
  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
}
