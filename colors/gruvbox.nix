localFlake: {myLib, ...}: let
  inherit (myLib) specifyHexFormat;
  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;
in {
  flake.themes.gruvbox = let
    neovim = {
      plugin = pkgs.vimPlugins.gruvbox-nvim;
      config = ''
        lua << EOF
          require("gruvbox").setup {
            contrast = "hard"
          }
        EOF
      '';
    };

    gtk = {
      cursorTheme = {
        name = "Capitaine Cursors (Gruvbox)";
        package = pkgs.capitaine-cursors-themed;
      };
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
      inherit (gtk.cursorTheme) name package;
      gtk.enable = true;
      x11.enable = true;
    };

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
        background = "1D2021";
        foreground = "ebdbb2";
      };

      extra = {
        alternate-background = "282828";
        orange = {
          bright = "fe8019";
          normal = "d65d0e";
        };
      };
    };
  in {
    inherit colors gtk pointerCursor; # neovim;
  };
}
