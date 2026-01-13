{ pkgs, ... }:
{
  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    symbola
    jetbrains-mono
    fira-code
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [
      "Noto Serif"
    ];
    sansSerif = [
      "Noto Sans"
    ];
    monospace = [
      "JetBrainsMono"
      "Noto Mono"
    ];
  };
  fonts.fontconfig.antialias = true;
  fonts.fontconfig.hinting.enable = true;

  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.fontconfig.allowBitmaps = false;
}
