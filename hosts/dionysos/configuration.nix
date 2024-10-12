{
  config,
  pkgs,
  ...
}:
let
  username = "harry123";
in
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

  system.stateVersion = "24.05";

  users.users.${username} = {
    isNormalUser = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA8sdToNavEQv7PTMJ97HIGM6UlChwGS3x9O8hFilzui harryh@ik.me"
    ];
  };

  users.users.${username}.initialHashedPassword = "$y$j9T$s4isXqWcg4N8TEPjmj0fD/$zog2cpUwstnvwDnQsFmH3br/WAeD2Uu/L7ePr00cKkA";
  environment.variables.EDITOR = "nvim";
}
