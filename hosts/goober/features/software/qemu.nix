{pkgs, config, ...}: {

  environment.systemPackages = with pkgs; [
    spice-gtk
    quickemu
    qemu
  ];

  virtualisation.spiceUSBRedirection.enable = true;

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}
