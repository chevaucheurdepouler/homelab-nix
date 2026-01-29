{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zathura
    bitwarden-desktop
    nil
    obs-studio
    osu-lazer-bin
    signal-desktop
    iamb
    qutebrowser
    ente-desktop
    moonlight-qt
    podman-compose
  ];

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
