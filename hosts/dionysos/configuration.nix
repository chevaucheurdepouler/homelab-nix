{
  config,
  pkgs,
  ...
}:
let
  username = "harry123";
in
{
  imports = [ ../../features/server/tailscale.nix ];
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

  users.users.${username}.initialHashedPassword =
    "$y$j9T$s4isXqWcg4N8TEPjmj0fD/$zog2cpUwstnvwDnQsFmH3br/WAeD2Uu/L7ePr00cKkA";

  environment.variables.EDITOR = "nvim";

  # TODO: migrate this to sisyphe
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    # You'd think this is a good idea, but Safari doesn't support 1.3 on websockets yet from my testing in 2020.  If one is only using Chrome, consider it.
    # sslProtocols = "TLSv1.3";
    virtualHosts = {
      "irc.hypervirtual.world" = {
        forceSSL = true;
        enableACME = true;
        locations."^~ /weechat" = {
          proxyPass = "http://127.0.0.1:9000/weechat/";
          proxyWebsockets = true;
        };
        locations."/" = {
          root = pkgs.glowing-bear;
        };
      };
    };

    services.oauth2.proxy = {
      enable = true;
      email.addresses = ''
        # your email goes here for authorization
      '';
      nginx.virtualhosts = [
        "irc.hypervirtual.world"
      ];
      clientID = "";
      keyFile = "";
    };
  };
}
