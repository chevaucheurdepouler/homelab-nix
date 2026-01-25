{ pkgs, ... }:
{
  services.mealie = {
    enable = true;
    database.createLocally = true;
    settings = { };
  };
}
