{
  flake-parts-lib,
  inputs,
  ...
}:
{
  flake.homeModules.niri = flake-parts-lib.importApply ./niri.nix {
    inherit inputs;
  };
}
