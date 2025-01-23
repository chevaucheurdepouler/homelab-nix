{config, pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [ ircdHybrid ];

  services.ircdHybrid = {
    enable = true;
    serverName = "irc.hypervirtual.world";
    description = "welcome to the silly kittens hut !! meow:3";
    adminEmail = "admin@hypervirtual.world";
  };

  /**environment.etc = {
    "ircd.conf" = {
      text =''
      '';
      mode = "440";
    };
  };**/
}

