{ pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = (
      pkgs.callPackage
        "${builtins.fetchurl "https://raw.githubusercontent.com/jpds/nixpkgs/a33b02fa9d664f31dadc8a874eb1a5dbaa9f4ecf/pkgs/servers/caddy/default.nix"}"
        {
          externalPlugins = [
            {
              name = "caddy-dns/acmedns";
              repo = "https://github.com/caddy-dns/acmedns";
              version = "";
            }
            {
              name = "caddy-dns/cloudflare";
              repo = "https://github.com/caddy-dns/cloudflare";
              version = "";
            }
          ];
        }
    );

    virtualHosts = {
      "hypervirtual.world" = {
        serverAliases = [ "www.hypervirtual.world" ];
        extraConfig = ''
          encode zstd gzip
          reverse_proxy 192.168.1.203:8088
        '';
      };
      "git.hypervirtual.world".extraConfig = ''
        reverse_proxy 192.168.1.177:80
        encode zstd gzip
      '';

      "freshrss.hypervirtual.world".extraConfig = '''';
      "status.hypervirtual.world".extraConfig = '''';
      "books.hypervirtual.world".extraConfig = '''';
      "fish.hypervirtual.world".extraConfig = '''';
      "cloud.hypervirtual.world".extraConfig = ''
        redir /.well-known/carddav /remote.php/dav/ 301
        redir /.well-known/caldav /remote.php/dav/ 301

        reverse_proxy 192.168.1.177:80
        encode zstd gzip
      '';

      # TODO: migrate rougebordeaux config
      "rougebordeaux.xyz" = {

      };

      "pds.rougebordeaux.xyz".extraConfig = '''';
    };
  };
}
