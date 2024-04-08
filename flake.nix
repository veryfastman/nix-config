{
  description = "My NixOS configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    impermanence.url = "github:nix-community/impermanence";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    wallpaper-collection.url = "github:veryfastman/wallpaper-collection";
    wallpaper-collection.flake = false;
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./colors
        ./machines
        ./homeModules
        ./nixosModules
      ];
      systems = ["x86_64-linux"];
      _module.args.myLib = import ./lib.nix {inherit inputs;};
      perSystem = {
        pkgs,
        system,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            just
            nixos-install-tools
            nixos-rebuild
          ];
        };

        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [inputs.nur.overlay];
        };
      };

      flake.formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
    };
}
