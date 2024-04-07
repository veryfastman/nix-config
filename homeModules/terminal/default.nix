{config, ...}: {
  flake.homeModules.terminal.imports = with config.flake.homeModules; [
    alacritty
    bash
    direnv
    git
    nushell
    starship
    yazi
    zellij
  ];

  imports = [
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./nushell.nix
    ./starship.nix
    ./yazi.nix
    ./zellij.nix
  ];
}
