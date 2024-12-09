localFlake: { myLib, ... }:
let
  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.themes.dracula = {
    cursorTheme = {
      name = "Capitaine Cursors (Palenight)";
      package = pkgs.capitaine-cursors-themed;
    };

    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };

    colors = localFlake.inputs.nix-colors.colorschemes.dracula;

    extraNeovimPlugins = [
      {
        plugin = pkgs.vimPlugins.dracula-nvim;
        config = ''
          lua << EOF
            vim.cmd.colorscheme("dracula")
          EOF
        '';
      }
    ];
  };
}
