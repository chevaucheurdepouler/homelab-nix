{config, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    archivebox
  ];
}
