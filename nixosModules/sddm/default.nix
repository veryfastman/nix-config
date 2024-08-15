{ config, flake-parts-lib, ... }: {
  flake.nixosModules.sddm = flake-parts-lib.importApply ./sddm.nix { inherit config; };
}
