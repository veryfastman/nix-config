{
  config,
  lib,
  ...
}: {
  flake.homeModules.desktop.imports = with config.flake.homeModules; [
    desktop-packages
    hyprland
    # river
    # sway
  ];

  flake.homeModules.desktop-packages = {
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkOption types;
  in {
    options.desktop.windowManagerPackages = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [
        bluetuith
        brightnessctl
        cinnamon.nemo
        grim
        imv
        pavucontrol
        playerctl
        slurp
        wl-clipboard
      ];
      description = "List of packages to be installed when using a window manager";
    };
  };

  imports = [
    # ./river.nix
    ./hyprland.nix
  ];
}
