{
  description = "the silliest NixOS config!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgsSmall.url = "github:NixOS/nixpkgs/nixos-25.05-small";
    nixpkgsUnstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      follows = "nixpkgsUnstable";
    };

    nix-secrets = {
      url = "git+https://git.rougebordeaux.xyz/misschloe/nix-secrets.git"; # replace with your own repo
      flake = false;
    };

    /*
        nix-secrets-next = {
          url = "git+https://git.rougebordeaux.xyz/harry123/nix-secrets-next.git";
          flake = false;
        };
    */

    miovim.url = "git+https://git.rougebordeaux.xyz/misschloe/miovim.git";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgsUnstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    catppuccin.url = "github:catppuccin/nix";
    swww.url = "github:LGFae/swww";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgsUnstable";
    };
    musnix = {
      url = "github:musnix/musnix";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      catppuccin,
      nixpkgsSmall,
      nixpkgsUnstable,
      sops-nix,
      nixos-generators,
      nix-darwin,
      nix-flatpak,
      home-manager,
      zen-browser,
      musnix,
      lix-module,
      ...
    }@inputs:
    let
      username = "misschloe777";
      secrets = builtins.toString inputs.nix-secrets;

      specialArgs = {
        inherit username;
        inherit secrets;
        inherit inputs;
      };

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
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

        labouse = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/labouse/configuration.nix
          ];
        };

        goober = nixpkgsUnstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/goober/configuration.nix
            lix-module.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            musnix.nixosModules.musnix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./home-manager/home.nix
                  catppuccin.homeModules.catppuccin
                ];

                home.packages = [
                  inputs.miovim.packages.${system}.default
                ];
              };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
          ];
        };

        workstation = nixpkgsUnstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = specialArgs;
          modules = [
            ./hosts/workstation/configuration.nix
            # lix-module.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./home-manager/home.nix
                  catppuccin.homeModules.catppuccin
                ];

                home.packages = [
                  inputs.miovim.packages.${system}.default
                ];
              };
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
            { programs.nix-ld.enable = true; }
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

        # vps for tracking errors
        diva = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          specialArgs = {
            diskSize = 20 * 1024;
            inherit specialArgs;
          };
          modules = [
            ./hosts/diva/configuration.nix
          ];
          format = "proxmox";
        };
      };

      darwinConfigurations."iMac-de-Eddie" = nix-darwin.lib.darwinSystem {
        modules = [
          sops-nix.darwinModules.sops
          ./hosts/dadarwin/configuration.nix
          /*
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.harry123 = ./home-manager/home.nix;
            }
          */
          { system.configurationRevision = self.rev or self.dirtyRev or null; }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."iMac-de-Eddie".pkgs;

      packages.miku-cursor-linux = pkgs.callPackage ./packages/miku-cursor.nix { };
      packages.fourget = pkgs.callPackage ./packages/4get.nix { };
    };

}
