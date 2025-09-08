localFlake:
{ config, ... }:
{
  imports = [
    localFlake.inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = false;
  home-manager.useUserPackages = true;

  home-manager.sharedModules = [
    {
      nixpkgs.config = {
        allowUnfree = true;
      };
      nixpkgs.overlays = [ localFlake.inputs.niri.overlays.niri ];
      home.stateVersion = config.system.stateVersion;
      imports = [ localFlake.config.flake.homeModules.default ];
    }
    localFlake.inputs.sops-nix.homeManagerModules.sops
  ];
}
