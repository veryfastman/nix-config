localFlake: { config, ... }: {
  imports = [
    localFlake.inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.sharedModules = [
    {
      home.stateVersion = config.system.stateVersion;
      imports = [ localFlake.config.flake.homeModules.default ];
    }
  ];
}
