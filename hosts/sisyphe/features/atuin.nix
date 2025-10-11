{ config, ... }:
{
  services.atuin = {
    enable = true;
    database.uri = "";
  };
}
