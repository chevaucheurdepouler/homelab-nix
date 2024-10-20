{inputs, config, pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ];

  programs.neovim = { 
    enable = true; 
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    defaultEditor = true;
  };
}
