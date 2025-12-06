{ ... }:
{
  services.lldap = {
    enable = true;
    settings = {
      force_ldap_user_pass_reset = "always";
    };
    environment = {
      LLDAP_LDAP_USER_PASS_FILE = "/run/secrets/ldap_password";
      LLDAP_LDAP_KEY_SEED_FILE = "/run/secrets/ldap_seed_file";
    };
  };

  services.authelia = {
    instances = {
      default = {
        enable = true;
        settings = {
        };
      };
    };
  };
}
