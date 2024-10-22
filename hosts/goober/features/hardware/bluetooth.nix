{config, pkgs, ...}: {
  hardware.bluetooth = { enable = true; # enables support for Bluetooth

  powerOnBoot = true; # powers up the default Bluetooth controller on boot 
  };
  services.blueman.enable = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

 services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
    "wireplumber.settings" = {
      "bluetooth.autoswitch-to-headset-profile" = false;
    };
  };
}
