{ ... }:
{
  services.borgmatic = {
    enable = true;
    configurations = {
      storageBox = {
        postgresql_databases = [
          { name = "nextcloud"; }
        ];
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
