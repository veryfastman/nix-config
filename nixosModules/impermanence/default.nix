{
  flake-parts-lib,
  inputs,
  ...
}: {
  flake.nixosModules.impermanence = flake-parts-lib.importApply ./impermanence.nix {inherit inputs;};
}
