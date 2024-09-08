{
  description = "the silliest NixOS config!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.url = "github:Mic92/sops-nix";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    nix-secrets = {
      url = "git+https://git.hypervirtual.world/harry123/nix-secrets.git";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      ...
    }@inputs:
    let
      username = "harry123";
      secrets = builtins.toString inputs.nix-secrets;

      specialArgs = {
        inherit username;
        inherit secrets;
      };
    in
    {
      nixosConfigurations = {
        sisyphe = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/sisyphe/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };

        labouse = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/labouse/configuration.nix
          ];
        };

        goober = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./features/isos/goober.nix
          ];
        };
      };

    };
}
