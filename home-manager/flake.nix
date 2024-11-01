{
  description = "Home Manager configuration of harry123";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    in {
      homeConfigurations."harry123" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix 
          {
              nixpkgs.overlays = overlays;
          }
        ];

        specialArgs = {
            inherit inputs;
          };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
