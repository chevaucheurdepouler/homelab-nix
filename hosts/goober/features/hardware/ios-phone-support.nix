{ config, pkgs, ... }:
{
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.systemPackages = with pkgs; [
    libimobiledevice
    usbutils
    ifuse # optional, to mount using 'ifuse'
  ];

}
