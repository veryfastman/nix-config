localFlake:
{myLib, ...}:
let
  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  flake.colors.gruvbox = let
    inherit (myLib) specifyHexFormat;

    neovim = {
      plugin = pkgs.vimPlugins.gruvbox-nvim;
      config = ''
        require("gruvbox").setup {
          contrast = "hard"
        }
      '';
    };

    cursorTheme = {
      name = "Capitaine Cursors (Gruvbox)";
      package = pkgs.capitaine-cursors-themed;
    };

    gtk = {
      inherit cursorTheme;
      theme = {
        name = "Gruvbox-Dark-B";
        package = pkgs.gruvbox-gtk-theme;
      };
      iconTheme = {
        name = "Gruvbox-Plus-Dark";
        package = pkgs.gruvbox-plus-icons;
      };
    };

    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
    } // cursorTheme;

    colors = {
      bright = {
        black = "928374";
        blue = "83a598";
        cyan = "8ec07c";
        green = "b8bb26";
        magenta = "d3869b";
        red = "fb4934";
        white = "ebdbb2";
        yellow = "fabd2f";
      };

      normal = {
        black = "282828";
        blue = "458588";
        cyan = "689d6a";
        green = "98971a";
        magenta = "b16286";
        red = "cc241d";
        white = "a89984";
        yellow = "d79921";
      };

      primary = {
        alternate-background = "282828";
        background = "1D2021";
        foreground = "ebdbb2";
      };
    };
  in {
    inherit colors gtk pointerCursor neovim;
    alacrittyCompatible = specifyHexFormat (colors // {primary = builtins.removeAttrs colors.primary ["alternate-background"];}) "0x";
    normalHex = specifyHexFormat colors "#";
  };
}
