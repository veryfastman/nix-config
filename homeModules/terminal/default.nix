{config, ...}: {
  flake.homeModules.terminal.imports = with config.flake.homeModules; [
    alacritty
    bash
    direnv
    nushell
    starship
    yazi
    zellij
  ];

  imports = [
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./zellij.nix
  ];
}
