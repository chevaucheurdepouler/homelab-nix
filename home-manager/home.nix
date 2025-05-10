{
  config,
  pkgs,
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    beeper
    nerd-fonts.code-new-roman
    ffmpegthumbnailer
    xfce.tumbler
    dm-sans
    zoxide
    btop
    bitwarden-cli
    weechat
    cava
    hyfetch
    kittysay
    nextcloud-client
    thunderbird-bin
    feh
    waybar
    p7zip

    libreoffice-qt
    tetrio-desktop

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
    gimp-with-plugins
    fzf
    lf

    prismlauncher

    wofi
    wofi-emoji
    obsidian

    audacious
    audacious-plugins

    libsixel
    unzip
    p7zip

    libsixel
    unzip
    p7zip

    nixfmt-rfc-style
    fuzzel
    zsh-syntax-highlighting

    obsidian
    papirus-icon-theme
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
    # ".config/sway".source = dotfiles/sway;
    ".config/foot".source = dotfiles/foot;
    ".profile".source = dotfiles/.profile;
    ".config/waybar".source = dotfiles/waybar;
    ".config/cava".source = dotfiles/cava;
    ".bashrc".source = dotfiles/bash/.bashrc;
    ".config/hyfetch.json".source = dotfiles/hyfetch/hyfetch.json;
    ".config/niri".source = dotfiles/niri;
    ".config/fuzzel/fuzzel.ini".source = dotfiles/fuzzel/fuzzel.ini;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;
  programs.zoxide.enableZshIntegration = true;
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

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${config.home.homeDirectory}/Bureau";
      download = "${config.home.homeDirectory}/Téléchargements";
      music = "${config.home.homeDirectory}/Musique";
      pictures = "${config.home.homeDirectory}/Images";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Images/Captures\ d\'écrans";
      };
    };
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
          "image/jpeg" = "feh.desktop";
          "image/png" = "feh.desktop";
      };
    };
  */

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
  };

  gtk.theme = {
    package = pkgs.catppuccin-gtk;
  };

  programs.foot = {
    enable = true;
    server.enable = true;
  };

  catppuccin = {
    flavor = "latte";
    mpv.enable = true;
    mako.enable = true;
    lazygit.enable = true;
    gtk.enable = true;
    fzf.enable = true;
    swaylock.enable = true;
  };

  home.shell.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = [
      "rm *"
      "pkill *"
      "cp *"
    ];

    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles/p10k;
        file = ".p10k.zsh";
      }
    ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
