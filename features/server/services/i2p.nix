{ config, pkgs, ... }:
{
  services.i2pd = {
    enable = true;
    upnp.enable = true;
  };
}
