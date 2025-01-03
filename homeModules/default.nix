{ config, ... }:
{
  flake.homeModules.default.imports = with config.flake.homeModules; [
    desktop
    graphic
    misc
    terminal
  ];

  imports = [
    ./module.nix
    ./desktop
    ./graphic
    ./misc
    ./terminal
  ];
}
