{
  services.akkoma.enable = true;
  services.akkoma.initDb.enable = true;
  services.akkoma.config = {
    ":pleroma" = {
      ":instance" = {
        name = "e^akkoma + 1 = 0";
        description = "the cuntiest french akkoma instance<3. centres d'intérêts : la mode, les sciences, la musique. mais ça ne vous empêche pas de parler de n'importe quoi! join us !";
        email = "admin@babychou.me";
        registration_open = false;
      };
      "Pleroma.Upload".base_url = "https://blurb.rougebordeaux.xyz";
      "Pleroma.Web.Endpoint" = {
        url.host = "eepy.rougebordeaux.xyz";
        http.port = 4004;
      };
    };
  };

  services.caddy.virtualHosts."http://blurb.rougebordeaux.xyz".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma-blurb.log
    }

    encode gzip

    reverse_proxy :4004
  '';

  services.caddy.virtualHosts."http://eepy.rougebordeaux.xyz".extraConfig = ''
    log {
      output file /var/log/caddy/akkoma.log
    }

    encode gzip

    reverse_proxy :4004
  '';
}
