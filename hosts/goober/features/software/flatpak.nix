{ config, ... }:
{
  services.flatpak.enable = true;

  services.flatpak.packages = [
    "dev.geopjr.Tuba"
    "org.vinegarhq.Sober"
    "com.github.libresprite.LibreSprite"
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly"; # Default value
  };
}
