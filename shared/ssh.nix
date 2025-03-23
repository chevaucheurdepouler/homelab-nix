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

  services.fail2ban.jails.sshd.settings = {
    ssh = ''
      enabled = true
      port = ssh
      filter = sshd
      logpath = %(sshd_log)s
      maxretry = 5
    '';
  };

}
