{ config, ... }:
{
  services.fail2ban = {
    enable = true;
    ignoreIP = [ "192.168.1.0/24" ];
    extraPackages = [ ];
    jails = {
      /*
        nextcloud = ''
             enabled = true;
             filter = nextcloud
             port = http,https
           '';
      */
    };
    sshd = ''
      enabled = true
      port = ssh
      logpath = %(sshd_log)s
      backend = %(sshd_backend)s
    '';
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
  };

}
