{ config, ... }:
{
  flake.homeModules.graphic.imports = with config.flake.homeModules; [
    mako
    rofi
    waybar
  ];

  imports = [
    ./mako.nix
    ./rofi.nix
    ./waybar.nix
  ];
}
