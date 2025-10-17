{
  config,

  ...
}:
{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  #FIXME: fail2ban ssh 25 error
  services.fail2ban.jails.sshd.settings = {
    ssh = ''
      enabled = true
      filter = sshd
      logpath = %(sshd_log)s
      maxretry = 5
    '';
  };

}
