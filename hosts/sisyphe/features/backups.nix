{
  config,
  secrets,
  pkgs,
  ...
}:
{
  imports = [
    ./backups-repos.nix
  ];

  sops.secrets.borgRepoPassword = { };
  sops.secrets.borgRemoteServerPassword = {
    sopsFile = "${secrets}/secrets/backup.yaml";
  };

  sops.secrets.sshBorgOffsiteBackup = {
    sopsFile = "${secrets}/secrets/backup.yaml";
  };

  sops.secrets.borgOffsiteBackupHostKeys = {
    sopsFile = "${secrets}/secrets/backup.yaml";
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
        postgresql_databases = [
          { name = "nextcloud"; }
        ];
        exclude_patterns = [ "/home/*/.cache" ];
        encryption_passcommand = "${pkgs.coreutils}/bin/cat /run/secrets/borgRemoteServerPassword";
        ssh_command = "ssh -o GlobalKnownHostsFile=${config.sops.secrets.borgOffsiteBackupHostKeys.path} -i ${config.sops.secrets.sshBorgOffsiteBackup.path}";
      };
    };
  };

  systemd.timers."borgmatic" = {
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "*-*-* 03:00:00";
      Persistent = true;
      WakeSystem = true;
      Unit = "borgmatic.service";
    };
  };
}
