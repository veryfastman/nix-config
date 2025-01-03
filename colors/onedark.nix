localFlake:
{ myLib, ... }:
let
  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;
in
{
  flake.themes.onedark = {
    cursorTheme = {
      name = "Capitaine Cursors";
      package = pkgs.capitaine-cursors-themed;
    };

    iconTheme = {
      name = "Qogir";
      package = pkgs.qogir-icon-theme;
    };

    colors = localFlake.inputs.nix-colors.colorschemes.onedark;

    extraNeovimPlugins = [
      {
        plugin = pkgs.vimPlugins.onedark-nvim;
        config = ''
          lua << EOF
            require("onedark").load()
          EOF
        '';
      }
    ];
  };
}
