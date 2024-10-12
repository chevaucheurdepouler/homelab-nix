{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    weechat
    tmux
  ];

  services.weechat.enable = true;
  programs.tmux = {
    enable = true;
    clock24 = true;
  };
}
