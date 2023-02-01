{
  description = "A very basic flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
      # home-manager.url = "github:nix-community/home-manager";
      # home-manager.inputs.nixpkgs.follows = "nixpkgs";
      # nix will normally use the nixpkgs defined in home-managers inputs, we only want one copy of nixpkgs though
      darwin.url = "github:lnl7/nix-darwin";
      darwin.inputs.nixpkgs.follows = "nixpkgs"; # ...
  };

  outputs = { self, nixpkgs, darwin }: {
    darwinConfigurations."h-macbook-m1" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/2020m1/default.nix
      ];
      inputs = { inherit darwin nixpkgs; };
    };
  };
}
