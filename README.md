# My NixOS Configuration

This is my work-in-progress configuration for NixOS.

## Features

- Impermanence
- Uses flake-parts for extra modularity
- Custom framework for writing colorschemes
- Neovim config written using Nixvim
- Automatic disk partitioning by Disko (UEFI systems only)
- And more

## Plans

- [ ] Secrets management
- [ ] Use [nix-colors](https://github.com/Misterio77/nix-colors) instead of own module
- [ ] More window manager configurations (especially X window managers like dwm, awesome, xmonad, etc.)

## [Installation Guide](INSTALL.md)

## Use my Neovim config

If you have Flakes enabled:

```
nix run "github:veryfastman/nix-config"#nvim
```
