{ username, driveMountPoint }:

{
  # enable samba
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = hyperserver
      netbios name = hyperserver
      security = user
    '';
    shares = {
      music = {
        path = "${driveMountPoint}/Music";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = username;
      };
      ebooks = {
        path = "${driveMountPoint}/Ebooks";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = username;
      };
    };
  };

}
