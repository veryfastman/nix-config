localFlake:
{ myLib, ... }:
let
  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.themes.gruvbox = {
    cursorTheme = {
      name = "Capitaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
    };

    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };

    colors = localFlake.inputs.nix-colors.colorschemes.gruvbox-dark-hard;

    extraNeovimPlugins = [
      {
        plugin = pkgs.vimPlugins.gruvbox-nvim;
        config = ''
          lua << EOF
            require("gruvbox").setup {
              contrast = "hard"
            }
            vim.cmd.colorscheme("gruvbox")
          EOF
        '';
      }
    ];
  };
}
