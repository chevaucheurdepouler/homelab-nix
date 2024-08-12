{ config, ... }:
{
  sops.secrets.borgRepoPassword = { };

  services.borgbackup.jobs = {
    localBackup = {
      paths = "/";
      exclude = [
        "/nix"
        "/srv/Multimedia"
        "/srv/media"
        "/srv/backups/serverBackups"
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
}
