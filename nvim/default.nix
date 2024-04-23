{ self
, inputs
, myLib
, ...
}: {
  perSystem =
    { pkgs
    , system
    , ...
    }:
    let
      nvim = inputs.nixvim.legacyPackages."${system}".makeNixvimWithModule nixvimModule;
      nixvimModule = {
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ inputs.neorg-overlay.overlays.default ];
        };
        module =
          import ./config
          // {
            extraPlugins = self.nixosConfigurations.laptop.config.home-manager.users.donny.theme.extraNeovimPlugins;
          };
        extraSpecialArgs = { inherit myLib; };
      };
    in
    {
      checks.nvim = inputs.nixvim.lib."${system}".check.mkTestDerivationFromNixvimModule nixvimModule;
      packages = {
        inherit nvim;
      };
    };
}
