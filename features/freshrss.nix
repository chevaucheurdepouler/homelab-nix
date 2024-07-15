{ lib, ... }:
{
  services.freshrss = {
    enable = true;
    language = "fr";
    database = {
      type = "sqlite";
    };
  };
}
