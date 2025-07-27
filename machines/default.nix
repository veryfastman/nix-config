{
  config,
  flake-parts-lib,
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations = {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        inputs.niri.nixosModules.niri
        (import ../disko.nix { device = "/dev/nvme0n1"; })
        (flake-parts-lib.importApply ./laptop { inherit config inputs self; })
      ];
    };
  };
}
