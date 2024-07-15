{ }:
{
  #TODO: implement uptime-kama
  services.uptime-kama = {
    enable = true;
    settings = {
      PORT = "4000";
    };
  };
}
