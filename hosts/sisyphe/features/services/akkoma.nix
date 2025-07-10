{pkgs, ...}:{
  services.akkoma.enable = true;
  services.akkoma.initDb.enable = true;
  services.akkoma.config = {
    ":pleroma" = {
      ":instance" = {
        name = "e^akkoma + 1 = 0";
        description = "the cuntiest french akkoma instance<3. centres d'intérêts : la mode, les sciences, la musique. mais ça ne vous empêche pas de parler de n'importe quoi! join us !";
        email = "admin@babychou.me";
        registration_open = false;
	max_pinned_statuses = 1;
      };
      "Pleroma.Web.Endpoint" = {
	http.ip = "127.0.0.1";
	http.port = 4000;
        url.host = "eepy.rougebordeaux.xyz";
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
      ":configurable_from_database" = true;
    };
  };

  services.caddy.virtualHosts."http://eepy.rougebordeaux.xyz".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma.log
    }

    encode gzip

    reverse_proxy 127.0.0.1:4000
  '';
  services.caddy.virtualHosts."http://blurb.rougebordeaux.xyz".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma_media.log
    }

    encode gzip

    reverse_proxy 127.0.0.1:4000
  '';
}
