{ pkgs, config, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };

  services.networkd-dispatcher = {
    enable = true;
    rules."50-tailscale" = {
      onState = [ "routable" ];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -K ens18 rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
}
