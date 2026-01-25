{ pkgs, config, ... }:
{
  # services.mysql = {
  #   enable = false;
  #   package = pkgs.mariadb;
  # };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    ensureDatabases = [
      "cloudreve"
      "forgejo"
      "bitmagnet"
    ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
    '';
  };
}
