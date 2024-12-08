{config, pkgs, ...}: 
{
  services.ircdHybrid = {
    enable = true;
    serverName = "irc.hypervirtual.world";
    description = "welcome to the silly kittens hut !! meow:3";
    adminEmail = "admin@hypervirtual.world";
  };
}

