{config, pkgs, ...}: 
{
  environment.systemPackages = with pkgs; [ ircdHybrid ];

  services.ircdHybrid = {
    enable = true;
    serverName = "irc.rougebordeaux.xyz";
    description = "welcome to the silly kittens hut !! meow:3";
    adminEmail = "admin@rougebordeaux.xyz;
  };

  /**environment.etc = {
    "ircd.conf" = {
      text =''
      '';
      mode = "440";
    };
  };**/
}

