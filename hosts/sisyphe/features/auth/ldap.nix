{ secrets-next, ... }:
{
  sops.secrets."ldap_password" = {
    sopsFile = "${secrets-next}/secrets/bordel.yaml";
  };
  sops.secrets."ldap_seed_file" = {
    sopsFile = "${secrets-next}/secrets/bordel.yaml";
  };
  services.lldap = {
    enable = true;
    settings = {
      force_ldap_user_pass_reset = "always";
      ldap_base_dn = "cn=pouler,ou=bassecour,dc=rougebordeaux,dc=xyz";
    };
    environment = {
      LLDAP_LDAP_USER_PASS_FILE = "/run/secrets/ldap_password";
      LLDAP_LDAP_KEY_SEED_FILE = "/run/secrets/ldap_seed_file";
    };
  };

  # services.authelia = {
  #   instances = {
  #     default = {
  #       enable = true;
  #       secrets.storageEncryptionKeyFile = "/etc/authelia/storageEncryptionKeyFile";
  #       secrets.jwtSecretFile = "/etc/authelia/jwtSecretFile";
  #       settings = {
  #         access_control = {
  #           default_policy = "deny";
  #           rules = [
  #             {
  #               "domain" = "*.rougebordeaux.xyz";
  #               "policy" = "one_factor";
  #             }
  #           ];
  #         };
  #       };
  #     };
  #   };
  # };
}
