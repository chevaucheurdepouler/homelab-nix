{ config, ... }:
{
  services.flatpak.enable = true;

  services.flatpak.packages = [
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
}
