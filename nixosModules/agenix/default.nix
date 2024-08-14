{ flake-parts-lib
, inputs
, ...
}: {
  flake.nixosModules.agenix = flake-parts-lib.importApply ./agenix.nix { inherit inputs; };
}
