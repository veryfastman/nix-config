{ config
, flake-parts-lib
, ...
}: {
  flake.homeModules.desktop.imports = with config.flake.homeModules; [
    desktop-packages
    hyprland
    # xmonad
    # river
    # sway
  ];

  flake.homeModules.desktop-packages =
    { lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkOption types;
    in
    {
      options.desktop.windowManagerPackages = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
          bluetuith
          brightnessctl
          grim
          imv
          pavucontrol
          pcmanfm
          playerctl
          polkit_gnome
          slurp
          wl-clipboard
          wlr-randr
        ];
        description = "List of packages to be installed when using a window manager";
      };
    };

  imports = [
    # ./river.nix
    (flake-parts-lib.importApply ./hyprland.nix { inherit config; })
  ];
}
