{pkgs, config, ...}: {

  environment.systemPackages = with pkgs; [
    quickemu
    qemu
  ];

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
}
