inputs@{
  flake-parts,
  git-hooks-nix,
  nixpkgs,
  nur,
  ...
}:
flake-parts.lib.mkFlake { inherit inputs; } {
  imports = [
    git-hooks-nix.flakeModule
    ./shell.nix
    ./colors
    ./machines
    ./homeModules
    ./nixosModules
    ./nvim
  ];
  systems = [ "x86_64-linux" ];
  flake.formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
  _module.args.myLib = import ./lib.nix { inherit inputs; };
  perSystem =
    { system, ... }:
    {
      pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
      _module.args.pkgs = import nixpkgs {
        inherit system;
        overlays = [ nur.overlays.default ];
      };
    };
}
