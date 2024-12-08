{config, ...}: {
  services.znc.config.User."computemadness_" = {
    Admin = true;
    Nick = "computemadness_";
    AltNick = "kumputemadness_";
    LoadModule = [ "chanserver" "controlpanel" ];
    Network = { 
      libera = {
        Server = "irc.libera.chat +6697";
        LoadModule = "simple_away";
        Chan = {
          "#nixos" = {Detached = false;};
        };
      };
      koshkairc = {
        Server = "irc.koshka.love +6697";
        Chan = {
            "#" = {Detached = false;};
            "#speakez" = {Detached = false;};
          };
      };
    }; 
  };
}
