{ config, ... }:
{
  sops.secrets.smtp_address = { };
  sops.secrets.smtp_password = { };

  services.forgejo = {
    enable = true;
    lfs.enable = true;
    database = {
      type = "postgres";
    };
    settings = {
      server = {
        DOMAIN = "git.hypervirtual.world";
        ROOT_URL = "https://hypervirtual.world";
        HTTP_PORT = 3000;
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer = {
        ENABLED = true;
        SMTP_ADDR = config.sops.secrets.smtp_address;
      };
      service.DISABLE_REGISTRATION = true;
    };
    mailerPasswordFile = config.sops.secrets.smtp_password.path;
  };
}
