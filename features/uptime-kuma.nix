{ ... }:
{
  #TODO: implement uptime-kama
  services.uptime-kuma = {
    enable = true;
    settings = {
      HOST = "0.0.0.0";
      PORT = "4000";
    };
  };
}
