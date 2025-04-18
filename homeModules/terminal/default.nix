{ config, ... }:
{
  flake.homeModules.terminal.imports = with config.flake.homeModules; [
    alacritty
    bash
    direnv
    fish
    git
    lazygit
    newsboat
    nushell
    starship
    tmux
    yazi
    zellij
    zsh
  ];

  imports = [
    ./alacritty.nix
    ./bash.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./lazygit.nix
    ./nushell.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zellij.nix
    ./zsh.nix

    ./newsboat
  ];
}
