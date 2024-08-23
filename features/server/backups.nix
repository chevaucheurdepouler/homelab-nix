{ config, ... }:
{
  imports = [

  ];
  sops.secrets.borgRepoPassword = { };
  sops.secrets.borgRemoteServerPassword = {
    sopsFile = ../../secrets/backup.yaml;
  };

  services.borgbackup.jobs = {
    /*
            localBackup = {
              paths = "/";
              exclude = [
                "/nix"
                "/srv/Multimedia"
                "/srv/media"
                "/srv/backups/serverBackups"
                "/srv/backups/localComputerBackups"
                "/var/cache"
                "/var/run"
                "/tmp"
                "/proc"
                "/sys"
                "/dev"
                "/mnt"
                "/run"
              ];
              repo = "/srv/backups/serverBackups";
              doInit = true;
              encryption = {
                mode = "repokey";
                passCommand = "cat /run/secrets/borgRepoPassword";
              };
              compression = "auto,lzma";
              startAt = "weekly";
            };

            /*
              serverBackup = {

              };
    */
  };

  services.borgbackup.repos = {
    borgPersonalServer = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHyeTAANyYqMFded6mJHWuhGVXROu3TqDV2b8icjolfO root@meowcats-silly-computer"
      ];
      path = "/srv/backups/localComputerBackups";
    };
  };

  services.borgmatic = {
    enable = true;
    configurations = {
      remoteServer = {
        source_directories = [
          "/var"
          "/etc"
          "/home"
          "/srv/freshrss"
          "/srv/Minecraft"
        ];
        postgres_databases = [
          "forgejo"
          "nextcloud"
          "matrix-synapse"
        ];
        exclude_patterns = [ "/home/*/.cache" ];
        encryption_passcommand = "cat /run/secrets/borgRemoteServerPassword";
      };
    };
  };

  systemd.timers.borgmatic = {
    enable = true;
    unit = "borgmatic.service";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
      WakeSystem = true;
    };
  };
}
