{ ... }:
{
  #TODO: implement uptime-kama
  services.uptime-kuma = {
    enable = true;
    settings = {
      PORT = "4000";
    };
  };
}
