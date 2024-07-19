{ config, ... }:
{

  services.prometheus = {
    enable = true;
    port = 9001;
  };
  exporters = {
    node = {
      enable = true;
    };
  };
}
