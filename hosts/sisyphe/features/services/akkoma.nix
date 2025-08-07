{ pkgs, ... }:
let
  pleromaUrl = "eepy.rougebordeaux.xyz";
  pleromaMediaUrl = "blurb.rougebordeaux.xyz";
  theme = "fantasy-scroll-blossom";
  themeUrl = "https://plthemes.vulpes.one/themes/${theme}/${theme}.json";
  background = "";
  emojis = [ ];
  styles = ''
    {
      "pleroma-dark": [ "Pleroma Dark", "#121a24", "#182230", "#b9b9ba", "#d8a070", "#d31014", "#0fa00f", "#0095ff", "#ffa500" ],
      "pleroma-light": [ "Pleroma Light", "#f2f4f6", "#dbe0e8", "#304055", "#f86f0f", "#d31014", "#0fa00f", "#0095ff", "#ffa500" ],
      "classic-dark": [ "Classic Dark", "#161c20", "#282e32", "#b9b9b9", "#baaa9c", "#d31014", "#0fa00f", "#0095ff", "#ffa500" ],
      "bird": [ "Bird", "#f8fafd", "#e6ecf0", "#14171a", "#0084b8", "#e0245e", "#17bf63", "#1b95e0", "#fab81e"],
      "ir-black": [ "Ir Black", "#000000", "#242422", "#b5b3aa", "#ff6c60", "#FF6C60", "#A8FF60", "#96CBFE", "#FFFFB6" ],
      "monokai": [ "Monokai", "#272822", "#383830", "#f8f8f2", "#f92672", "#F92672", "#a6e22e", "#66d9ef", "#f4bf75" ],

      "redmond-xx": "/static/themes/redmond-xx.json",
      "redmond-xx-se": "/static/themes/redmond-xx-se.json",
      "redmond-xxi": "/static/themes/redmond-xxi.json",
      "breezy-dark": "/static/themes/breezy-dark.json",
      "breezy-light": "/static/themes/breezy-light.json",
      "mammal": "/static/themes/mammal.json",
      "${theme}": "/static/themes/${theme}.json"
    }
  '';
  akkoma-overlay = self: super: {
    akkoma = super.akkoma.overrideAttrs (old: {
      postPatch = ''
        cp ${./akkoma/style.json} $out/priv/static/themes/${theme}.json
        cp ${pkgs.writeText "styles.json" styles} $out/priv/static/themes
        cp ${./akkoma/terms-of-services.html} $out/priv/static/terms-of-service.html
      '';

      buildInputs = old.buildInputs ++ [
        pkgs.curl
      ];
    });
  };
in
{
  nixpkgs.overlays = [ akkoma-overlay ];
  services.akkoma.enable = true;
  services.akkoma.initDb.enable = true;
  services.akkoma.config = {
    ":pleroma" = {
      ":instance" = {
        name = "e^akkoma + 1 = 0";
        description = "the cuntiest french akkoma instance<3. on aime la mode, les sciences, et la musique.";
        email = "admin@babychou.me";
        registration_open = false;
        max_pinned_statuses = 1;
      };
      "Pleroma.Web.Endpoint" = {
        http.ip = "127.0.0.1";
        http.port = 4000;
        url.host = "${pleromaUrl}";
      };
      "Pleroma.Captcha.Kocaptcha" = {
        endpoint = "https://captcha.kotobank.ch";
      };
      "Pleroma.Upload" = {
        base_url = "https://blurb.rougebordeaux.xyz/media";
        link_name = true;
        filters = map (pkgs.formats.elixirConf { }).lib.mkRaw [
          "Pleroma.Upload.Filter.Exiftool"
          "Pleroma.Upload.Filter.Dedupe"
          "Pleroma.Upload.Filter.AnonymizeFilename"
        ];
      };
      ":configurable_from_database" = false;
      "frontend_configurations" = {
        "pleroma_fe" = {
          "theme" = "${theme}";
        };
      };
    };
  };

  services.caddy.virtualHosts."${pleromaUrl}".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma.log
    }

    encode zstd gzip
    reverse_proxy 127.0.0.1:4000
  '';

  services.caddy.virtualHosts."${pleromaMediaUrl}".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma_media.log
    }

    encode zstd gzip
    reverse_proxy 127.0.0.1:4000
  '';
}
