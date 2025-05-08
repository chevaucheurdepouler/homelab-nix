{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    archivebox
    nodejs_23
  ];

  services.caddy.virtualHosts."archive.rougebordeaux.xyz".extraConfig = ''
    reverse_proxy 15632
  '';

  systemd.services."archivebox-web" = {
    enable = true;
    description = "Runs the archivebox web UI";
    preStart = ''
      mkdir -p /srv/archivebox
      chown archivebox:archivebox /srv/archivebox
      if [ ! -f /srv/archivebox/index.sqlite3 ]; then
        sudo -u archivebox ${pkgs.archivebox}/bin/archivebox init --path /srv/archivebox
      fi
    '';
    serviceConfig = {
      ExecStart = "${pkgs.archivebox}/bin/archivebox server 0.0.0.0:15632 --path /srv/archivebox";
      Restart = "always";
      User = "archivebox";
      Group = "archivebox";
      WorkingDirectory = "/var/lib/archivebox";
    };
    wantedBy = [ "multi-user.target" ];
  };

}
