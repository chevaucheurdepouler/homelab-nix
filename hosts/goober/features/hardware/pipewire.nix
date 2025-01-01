{config, pkgs, ...}:
{
  security.rtkit.enable = true;
  services.pipewire.enable = false;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  environment.systemPackages = [
    pkgs.pwvucontrol
  ];
}
