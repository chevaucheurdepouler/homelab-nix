{pkgs, username, ...}: {
  services.samba = {
    enable = true;
    openFirewall = true;
  };

  users.users.nas = {

  };

  users.users.${username} = {
    isNormalUser = true;
  };

  systemd.tempfiles.rules = [
    "d /srv/files 0755 nas nas"
  ];

  system.stateVersion = "24.11";
}