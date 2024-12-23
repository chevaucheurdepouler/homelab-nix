{ config, lib, pkgs, ... }:
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
    lfs.enable = true;
    database = {
      type = "postgres";
    };
    settings = {
      server = {
        DOMAIN = "git.hypervirtual.world";
        ROOT_URL = "https://git.hypervirtual.world";
        HTTP_PORT = 3333;
      };
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      mailer = {
        ENABLED = true;
      };
      service.DISABLE_REGISTRATION = true;
    };
    mailerPasswordFile = config.sops.secrets.smtp_password.path;
  };

/*
  sops.secrets.forgejo-runner-token = {
    owner = "forgejo";
  };
  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "https://git.hypervirtual.world";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = config.sops.secrets.forgejo-runner-token.path;
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
        "ubuntu-22.04:docker://node:16-bullseye"
        ## optionally provide native execution on the host:
        # "native:host"
      ];
    };
  };
*/
  systemd.services.forgejo.preStart = ''
    create="${lib.getExe config.services.forgejo.package} admin user create"
    $create --admin --email "`cat ${config.sops.secrets.forgejoInitialMail.path}`" --username you --password "`cat ${config.sops.secrets.forgejoInitialPassword.path}`" &>/dev/null || true
  '';

  services.caddy.virtualHosts."http://git.hypervirtual.world".extraConfig = ''
        reverse_proxy :3333
      '';
}
