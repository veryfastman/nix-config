{config, ...}: {
  flake.homeModules.graphic.imports = with config.flake.homeModules; [
    rofi
    waybar
  ];

  imports = [
    ./rofi.nix
    ./waybar.nix
  ];
}
