{ config, ... }:
{
  flake.homeModules.terminal.imports = with config.flake.homeModules; [
    alacritty
    bash
    direnv
    fish
    git
    newsboat
    nushell
    starship
    tmux
    yazi
    zellij
  ];

  imports = [
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./nushell.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zellij.nix

    ./newsboat
  ];
}
