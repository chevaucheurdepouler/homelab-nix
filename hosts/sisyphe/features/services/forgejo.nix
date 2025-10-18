{
  secrets-next,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./forgejo-smtp.nix ];
  sops.secrets.smtp_address = { };
  sops.secrets.smtp_password = {
    owner = "forgejo";
  };
  sops.secrets.forgejoInitialMail = {
    owner = "forgejo";
  };
  sops.secrets.forgejoInitialPassword = {
    owner = "forgejo";
  };

  services.forgejo = {
    enable = true;
    package = pkgs.forgejo;
    lfs.enable = true;
    database = {
      type = "postgres";
    };
    settings = {
      server = {
        DOMAIN = "git.rougebordeaux.xyz";
        ROOT_URL = "https://git.rougebordeaux.xyz";
        SSH_DOMAIN = "git.rougebordeaux.xyz";
        HTTP_PORT = 3333;
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer = {
        ENABLED = true;
      };
      service.DISABLE_REGISTRATION = false;
    };
    mailerPasswordFile = config.sops.secrets.smtp_password.path;
  };

  # setup fail2ban for forgejo
  services.fail2ban = {
    enable = true;
    jails = {
      forgejo = {
        settings = {
          logpath = "/var/log/forgejo/log/gitea.log";
          filter = "forgejo";
          port = "http,https,ssh";
          maxretry = 20;
          findtime = 300;
          bantime = 900;
        };
      };
    };
  };

  # authorize ssh cloning
  services.openssh.settings.AllowUsers = [
    "homelab"
    "forgejo"
  ];
  services.openssh.settings.UsePAM = true;

  # setup forgejo runner
  sops.secrets.forgejo-runner-token = {
    owner = "forgejo";
    sopsFile = "${secrets-next}/secrets/bordel.yaml";
  };
  /*
    # TODO: setup token into nix-secrets-next project
    services.gitea-actions-runner = {
      package = pkgs.forgejo-actions-runner;
      instances.default = {
        enable = true;
        name = "mint";
        url = "https://git.rougebordeaux.xyz";
        # Obtaining the path to the runner token file may differ
        # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
        tokenFile = config.sops.secrets.forgejo-runner-token.path;
        labels = [
          "ubuntu-latest:docker://node:24-bookworm"
        ];
      };
    };
  */

  systemd.services.forgejo.preStart = ''
    create="${lib.getExe config.services.forgejo.package} admin user create"
    $create --admin --email "`cat ${config.sops.secrets.forgejoInitialMail.path}`" --username you --password "`cat ${config.sops.secrets.forgejoInitialPassword.path}`" &>/dev/null || true
  '';

  services.caddy.virtualHosts."http://git.rougebordeaux.xyz".extraConfig = ''
    reverse_proxy :3333
  '';
}
