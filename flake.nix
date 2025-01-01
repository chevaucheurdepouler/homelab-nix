{
  description = "the silliest NixOS config!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgsSmall.url = "github:NixOS/nixpkgs/nixos-24.11-small";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";

    nix-secrets = {
      url = "git+https://git.hypervirtual.world/harry123/nix-secrets.git"; # replace with your own repo
      flake = false;
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1"; 
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgsSmall,
      sops-nix,
      nixos-generators,
      nix-darwin,
      nix-flatpak,
      anyrun,
      home-manager,
      ...
    }@inputs:
    let
      username = "harry123";
      secrets = builtins.toString inputs.nix-secrets;

      specialArgs = {
        inherit username;
        inherit secrets;
        inherit inputs;
      };
    in
    {
      nixosConfigurations = {
        sisyphe = nixpkgsSmall.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/sisyphe/configuration.nix
            sops-nix.nixosModules.sops
          ];
        };

        # athena = nixpkgs.lib.nixosSystem {}:

        labouse = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/labouse/configuration.nix
          ];
        };

        goober = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/goober/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak

            {environment.systemPackages = [ anyrun.packages."x86_64-linux".anyrun ];}

            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./home-manager/home.nix;
              
              home-manager.extraSpecialArgs = {inherit inputs;};
            }
          ];
        };

        dionysos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit specialArgs;
          };
          modules = [
            ./hosts/dionysos/configuration.nix
          ];
        };
      };

      isos = {
        goober = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./features/isos/goober.nix
          ];
        };
      };

      proxmox = {
        sisyphe = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          specialArgs = {
            diskSize = 600 * 1024;
            inherit specialArgs;
          };
          modules = [
            ./hosts/sisyphe/configuration.nix
            sops-nix.nixosModules.sops
          ];
          format = "proxmox";
        };

        dionysos = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          specialArgs = {
            diskSize = 20 * 1024;
            inherit specialArgs;
          };
          modules = [
            (
              { ... }:
              {
                nix.registry.nixpkgs.flake = nixpkgs;
              }
            )
            ./hosts/dionysos/configuration.nix
          ];
          format = "proxmox";
        };
      };

    darwinConfigurations."iMac-de-Eddie" = nix-darwin.lib.darwinSystem {
      modules = [ ./hosts/dadarwin/configuration.nix 
      
      {system.configurationRevision = self.rev or self.dirtyRev or null;}
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."iMac-de-Eddie".pkgs;
    };
}
