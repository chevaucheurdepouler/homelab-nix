{
  pkgs,
  inputs,
  lib,
  secrets-next,
  ...
}:
{
  # for java development on vscode
  programs.nix-ld.enable = true;
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi # optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
      droidcam-obs
    ];
  };
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "davinci-resolve"
      "vscode"
      "tetrio-desktop"
      "beeper"
      "exact-audio-copy"
    ];
  fonts.fontDir.enable = true;
  environment.systemPackages =
    with pkgs;
    [
      podman-compose
      zathura
      feishin
      libpng
      icu
      pcsx2
      figma-linux
      libreoffice-qt
      hunspell
      hunspellDicts.fr-any
      hunspellDicts.en-gb-large

      # video editing software
      #davinci-resolve

      # drawing software
      krita

      # 3d modeling
      blender
      signal-desktop
      weechat
      gvfs
      nil
      bitwarden-desktop
      ente-web
      # FIXME: cant fetch EAC because of cygwin mirrors
      # exactaudiocopy
      picard
      i2pd
      nicotine-plus
      mpd
      mpdas
      beets

      # games
      tetrio-desktop
      osu-lazer-bin
      esptool

      # needed for passing gpu to podman
      nvidia-container-toolkit
    ]
    ++ [
      inputs.affinity-nix.packages.${pkgs.system}.v3
    ];

  # sops.secrets.lastfm_password = {
  #
  #   sopsFile = "${secrets-next}/secrets/backup.yaml";
  # };
  #
  services.mpdscribble = {
    enable = true;
    endpoints = {
      "last.fm" = {
        passwordFile = "/run/secrets/lastfm_password";
        username = "ariburnznfire";
      };
    };
  };

  # podman stuff
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

  hardware.nvidia-container-toolkit.enable = true;
  environment.etc."cdi/nvidia-container-toolkit.json".source =
    "/run/cdi/nvidia-container-toolkit.json";
}
