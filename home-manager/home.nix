{
  config,
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "harry123";
  home.homeDirectory = "/home/harry123";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    nerd-fonts.code-new-roman

    dm-sans
    zoxide
    btop
    #pkgs.bitwarden
    weechat
    eclipses.eclipse-java # school wants us to use it...
    cava
    hyfetch
    kittysay
    nextcloud-client
    thunderbird-bin
    feh
    waybar
    p7zip

    playerctl
    wf-recorder

    file
    osu-lazer-bin

    qbittorrent

    i2pd

    ripgrep
    vscode

    zathura
    tor-browser

    gammastep
    lazygit
    xfce.thunar
    gimp-with-plugins
    fzf
    lf
    why3
    alt-ergo
    cvc4
    z3
    prismlauncher

    audacious
    audacious-plugins

    krita
    udiskie

    libsixel
    walker
    unzip
    p7zip

    nixfmt-rfc-style
    signal-desktop
    gajim
    blender
    # # You can also create simple shell scripts directly inside your
    #  # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".config/sway".source = dotfiles/sway;
    ".config/foot".source = dotfiles/foot;
    ".profile".source = dotfiles/.profile;
    ".config/waybar".source = dotfiles/waybar;
    ".config/cava".source = dotfiles/cava;
    ".bashrc".source = dotfiles/bash/.bashrc;
    ".config/hyfetch.json".source = dotfiles/hyfetch/hyfetch.json;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  imports = [
    inputs.anyrun.homeManagerModules.default
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];

  services.mpris-proxy.enable = true;

  services.udiskie = {
    enable = true;
    tray = "auto";
    automount = true;
  };

  programs.swaylock = {
    enable = true;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/harry123/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.pointerCursor = {
    name = "miku-cursor-linux";
    size = 32;
    gtk.enable = true;
    package = pkgs.callPackage ../packages/miku-cursor.nix { };
  };

  programs.git = {
    userName = "harry123";
    userEmail = "harryh@ik.me";
    enable = true;
    extraConfig = {
      credential.helper = "${pkgs.git.override { withLibsecret = true; }}/bin/git-credential-libsecret";
    };
  };

  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 49.0;
    longitude = 8.4;
  };
  /*
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = "firefox.desktop";
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/about" = "firefox.desktop";
          "x-scheme-handler/unknown" = "firefox.desktop";
          "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      };
    };
  */
  programs.foot = {
    enable = true;
    server.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
