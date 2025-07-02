{ pkgs, lib, ... }:
{
  # for java development on vscode
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "vscode"
      "tetrio-desktop"
      "beeper"
    ];

  environment.systemPackages = with pkgs; [
    zathura
    libreoffice-qt
    hunspell
    hunspellDicts.fr-any
    hunspellDicts.en-gb-large

    # recording software
    obs-studio

    gvfs

    nil
    bitwarden
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
