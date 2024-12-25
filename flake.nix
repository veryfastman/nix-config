{
  description = "My NixOS configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    nur.url = "github:nix-community/nur";
    impermanence.url = "github:nix-community/impermanence";

    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorg-overlay = {
      url = "github:nvim-neorg/nixpkgs-neorg-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper-collection = {
      url = "github:veryfastman/wallpaper-collection";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.git-hooks-nix.flakeModule
        ./colors
        ./machines
        ./homeModules
        ./nixosModules
        ./nvim
      ];
      systems = [ "x86_64-linux" ];
      flake.formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      _module.args.myLib = import ./lib.nix { inherit inputs; };
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;

          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              just
              nixos-install-tools
              nixos-rebuild
              libnotify
            ];

            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };

          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ inputs.nur.overlays.default ];
          };
        };
    };
}
