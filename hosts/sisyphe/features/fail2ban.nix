{ config, ... }:
{
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "192.168.1.0/24"
      "192.168.1.197"
    ];
    extraPackages = [ ];
    action_abuseipdb = "abuseipdb";
    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true;
    };
    jails = {
      /*
        nextcloud = ''
             enabled = true;
             filter = nextcloud
             port = http,https
           '';
      */
      jellyfin = ''
        backend = auto
        enabled = true
        port = 80,443
        protocol = tcp
        filter = jellyfin
        maxretry = 3
        bantime = 86400
        findtime = 43200
        logpath = ${config.services.jellyfin.logDir}/jellyfin*.log
      '';
    };
  };

  environment.etc = {
    /*
      "fail2ban/filter.d/nextcloud.conf".text = ''
           [Definition]
           _groupsre = (?:(?:,?\s*"\w+":(?:"[^"]+"|\w+))*)
           datepattern = ,?\s*"time"\s*:\s*"%%Y-%%m-%%d[T ]%%H:%%M:%%S(%%z)?"
           failregex = ^[^{]*\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Login failed:
                       ^[^{]*\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Trusted domain error.
                       ^[^{]*\{%(_groupsre)s,?\s*"remoteAddr":"<HOST>"%(_groupsre)s,?\s*"message":"Two-factor challenge failed:
           journalmatch = _SYSTEMD_UNIT=phpfpm-nextcloud.service
         '';
    */
    "fail2ban/filter.d/jellyfin.conf".text = ''
            [Definition]
      failregex = ^.*Authentication request for .* has been denied \(IP: "<ADDR>"\)\.
    '';
  };

}
