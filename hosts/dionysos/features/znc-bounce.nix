{config, ...}: {

  services.znc = {
    enable = true;
    mutable = false; # Overwrite configuration set by ZNC from the web and chat interfaces.
    useLegacyConfig = false; # Turn off services.znc.confOptions and their defaults.
    openFirewall = true; # ZNC uses TCP port 5000 by default.
    config = {
      Listener = {
        "Motd" = "welcome to hypervirtual's irc bouncer - using znc";
        "SSLProtocols" = "-SSLv2 -SSLv3 -TLSv1 +TLSv1.1 +TLSv1.2";
      };
    };
  };
}
