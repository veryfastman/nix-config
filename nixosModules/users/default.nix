{ flake-parts-lib, inputs, ... }:
{
  flake.nixosModules.users = flake-parts-lib.importApply ./users.nix { inherit inputs; };
}
