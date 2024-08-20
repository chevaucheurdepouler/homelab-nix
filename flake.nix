{
  description = "the silliest NixOS config!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    sops-nix.url = "github:Mic92/sops-nix";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
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

      specialArgs = {
        inherit username;
      };
    in
    {
      nixosConfigurations = {
        sisyphe = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
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
      };
    };
}
