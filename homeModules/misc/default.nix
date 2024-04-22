{ config
, flake-parts-lib
, inputs
, ...
}:
let
  inherit (flake-parts-lib) importApply;
in
{
  flake.homeModules.misc.imports = with config.flake.homeModules; [
    firefox
    impermanence
    scripts
    theme
    wallpapers
    zathura
  ];

  imports = [
    ./firefox.nix
    ./scripts.nix
    ./zathura.nix
    (importApply ./impermanence.nix { inherit inputs; })
    (importApply ./theme.nix { inherit config; })
    (importApply ./wallpapers.nix { inherit inputs; })
  ];
}
