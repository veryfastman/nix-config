{config, ...}: {
  flake.colors.default.imports = with config.flake.colors; [
    gruvbox
  ];

  imports = [
    ./module.nix
    ./gruvbox.nix
  ];
}
