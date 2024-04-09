{
  config,
  flake-parts-lib,
  inputs,
  ...
}: let
  inherit (flake-parts-lib) importApply;
in {
  flake.colors.default.imports = with config.flake.colors; [
    gruvbox
  ];

  imports = [
    ./module.nix
    (importApply ./gruvbox.nix {inherit inputs;})
  ];
}
