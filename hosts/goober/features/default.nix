{ config, ... }:
{
  imports = [
    ./software/default.nix
    ./hardware/default.nix
    ./mprisence.nix
  ];
}
