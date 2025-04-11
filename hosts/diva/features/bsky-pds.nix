{config, ...}:
{
  services.pds = {
    enable = true;
    pdsadmin.enable = true;
    environmentFiles = [];
    settings = {
      "PDS_HOSTNAME" = "pds.rougebordeaux.xyz";

    };
  };
}