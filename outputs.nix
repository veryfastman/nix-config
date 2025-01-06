inputs@{
  flake-parts,
  git-hooks-nix,
  treefmt-nix,
  nixpkgs,
  nur,
  ...
}:
flake-parts.lib.mkFlake { inherit inputs; } {
  imports = [
    git-hooks-nix.flakeModule
    treefmt-nix.flakeModule
    ./shell.nix
    ./colors
    ./machines
    ./homeModules
    ./nixosModules
    ./nvim
  ];
  systems = [ "x86_64-linux" ];
  _module.args.myLib = import ./lib.nix { inherit inputs; };
  perSystem =
    { pkgs, system, ... }:
    {
      pre-commit.settings.hooks.nixfmt-rfc-style.enable = true;
      treefmt = {
        projectRootFile = "INSTALL.md";
        programs.nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
        };
      };
      _module.args.pkgs = import nixpkgs {
        inherit system;
        overlays = [ nur.overlays.default ];
      };
    };
}
