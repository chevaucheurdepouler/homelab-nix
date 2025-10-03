{ pkgs, config }:
{
  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "monolith";
      url = "https://git.rougebordeaux.xyz";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = config.age.secrets.forgejo-runner-token.path;
      labels = [
        "ubuntu-latest:docker://node:22-bullseye"
        "ubuntu-22.04:docker://node:22-bullseye"
        "ubuntu-20.04:docker://node:22-bullseye"
        "ubuntu-18.04:docker://node:16-buster"
        ## optionally provide native execution on the host:
        # "native:host"
      ];
    };
  };
}
