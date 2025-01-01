{
  config,
  flake-parts-lib,
  ...
}:
{
  flake.homeModules.desktop.imports = with config.flake.homeModules; [
    desktop-packages
    hyprland
    xmonad
    river
    # river
    # sway
  ];

  flake.homeModules.desktop-packages =
    {
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkOption types;
    in
    {
      options.desktop = {
        windowManagerPackages = mkOption {
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

        xWindowManagerPackages = mkOption {
          type = types.listOf types.package;
          default = with pkgs; [
            bluetuith
            brightnessctl
            fireshot
            imv
            pavucontrol
            pcmanfm
            playerctl
            polkit_gnome
            xclip
            # xorg.xrandr
          ];
          description = "List of packages to be installed when using an X window manager.";
        };
      };
    };

  imports = [
    ./river.nix
    ./hyprland.nix
    ./xmonad.nix
  ];
}
