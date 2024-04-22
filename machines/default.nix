{ config
, flake-parts-lib
, inputs
, self
, ...
}: {
  flake.nixosConfigurations = {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        (import ../disko.nix { device = "/dev/nvme0n1"; })
        (flake-parts-lib.importApply ./laptop { inherit config self; })
      ];
    };
  };
}
