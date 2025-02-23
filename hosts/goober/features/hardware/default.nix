{ config, ... }:
{
  imports = [
    ./bluetooth.nix
    ./pipewire.nix
    ./nvidia.nix
    ./ios-phone-support.nix
  ];
}
