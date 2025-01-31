{config, ...}:
{
  imports = [
    ./wine.nix
    ./qemu.nix
    ./neovim.nix
    ./flatpak.nix
    ./discord.nix
    ./ollama.nix
  ];

}
