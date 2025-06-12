{ config, ... }:
{
  flake.homeModules.graphic.imports = with config.flake.homeModules; [
    eww
    mako
    rofi
    waybar
  ];

  imports = [
    ./eww

    ./mako.nix
    ./rofi.nix
    ./waybar.nix
  ];
}
