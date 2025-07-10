{ pkgs, config, ... }:
{
  services.mysql = {
    enable = false;
    package = pkgs.mariadb;
    /*
      ensureDatabases = [ "photoprism" ];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    */
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };
}
