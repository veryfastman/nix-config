localFlake: { config
            , lib
            , flake-parts-lib
            , myLib
            , ...
            }:
let
  inherit (builtins) concatStringsSep;
  inherit (lib) genAttrs mkEnableOption mkOption types;

  pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;

  createStringOption = default: description:
    mkOption {
      type = types.str;
      inherit default description;
    };

  colorLayout = types.submodule {
    options =
      {
        primary = genAttrs [ "background" "foreground" ] (name: createStringOption "000000" "Set the ${name}");
        extra = {
          alternate-background = createStringOption "000000" "Set another background";
          orange = genAttrs [ "bright" "normal" ] (name: createStringOption "000000" "Set the ${name} variant of the color orange");
        };
      }
      // genAttrs [ "bright" "normal" ] (categoryName:
        mkOption {
          type = types.submodule {
            options = genAttrs [
              "black"
              "blue"
              "cyan"
              "green"
              "magenta"
              "red"
              "white"
              "yellow"
            ]
              (name: createStringOption "000000" ("Color hex value for " + concatStringsSep " " [ categoryName name ]));
          };
          description = "Colors that are ${categoryName}";
        });
  };

  themeModule =
    { nameDefault
    , nameDescription
    ,
    }: { packageDefault
       , packageDescription
       ,
       }:
    types.submodule {
      options = {
        name = createStringOption nameDefault nameDescription;
        package = mkOption {
          type = types.package;
          default = packageDefault;
          description = packageDescription;
        };
      };
    };

  cursorThemeOptions = {
    name = createStringOption "Capitaine Cursors (Gruvbox)" "Name of the cursor theme to be used";
    package = mkOption {
      type = types.package;
      default = pkgs.capitaine-cursors-themed;
      description = "Cursor theme package";
    };
  };
in
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    themes = mkOption {
      default = { };
      description = "Desktop themes";
      type = types.lazyAttrsOf (
        types.submodule (
          { config, ... }: {
            options =
              let
                inherit (myLib) specifyHexFormat;
                colors = mkOption {
                  type = colorLayout;
                  default = { };
                  description = "Colors to be used by various configurations";
                  example = ''
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
                  '';
                };
              in
              {
                inherit colors;

                alacrittyCompatibleColorFormat = mkOption {
                  type = colorLayout;
                  default = specifyHexFormat config.colors "0x";
                  description = "Hex colors that are compatible with Alacritty";
                };

                normalHexColorFormat = mkOption {
                  type = colorLayout;
                  default = specifyHexFormat config.colors "#";
                  description = "General purpose hex color codes";
                };

                extraNeovimPlugins = mkOption {
                  type = types.listOf (types.submodule {
                    options = {
                      plugin = mkOption {
                        type = types.nullOr types.package;
                        default = null;
                        description = "Extra plugin to install";
                      };

                      config = mkOption {
                        type = types.nullOr types.lines;
                        default = null;
                        description = "Vim script configuration for the extra plugin";
                      };
                    };
                  });
                  example = ''
                    extraNeovimPlugins = [
                      {
                        plugin = pkgs.vimPlugins.gruvbox-nvim;
                        config = "lua require('gruvbox').setup()"
                      }
                    ];
                  '';
                  description = "Extra neovim plugins";
                };

                gtk = mkOption {
                  type = types.submodule {
                    options = {
                      cursorTheme = mkOption {
                        type = types.submodule {
                          options = {
                            inherit (cursorThemeOptions) name package;
                          };
                        };
                        example = ''
                          name = "Capitaine Cursors (Gruvbox)";
                          package = pkgs.capitaine-cursors-themed;
                        '';
                        description = "Name and package for the cursor theme";
                      };

                      theme = mkOption {
                        type =
                          themeModule
                            {
                              nameDefault = "Gruvbox-Dark-B";
                              nameDescription = "Name of the GTK theme to be used";
                            }
                            {
                              packageDefault = pkgs.gruvbox-gtk-theme;
                              packageDescription = "GTK package";
                            };
                        example = ''
                          name = "Gruvbox-Dark-B";
                          package = pkgs.gruvbox-gtk-theme;
                        '';
                        description = "Set the GTK theme";
                      };

                      iconTheme = mkOption {
                        type =
                          themeModule
                            {
                              nameDefault = "Gruvbox-Plus-Dark";
                              nameDescription = "Name of the icon theme to be used";
                            }
                            {
                              packageDefault = pkgs.gruvbox-plus-icons;
                              packageDescription = "Icon theme package";
                            };
                        example = ''
                          name = "Gruvbox-Plus-Dark";
                          package = pkgs.gruvbox-plus-icons;
                        '';
                        description = "Set the icon theme";
                      };
                    };
                  };
                };

                pointerCursor = mkOption {
                  type = types.submodule {
                    options = {
                      inherit (cursorThemeOptions) name package;
                      gtk.enable = mkEnableOption "Enable GTK cursor";
                      x11.enable = mkEnableOption "Enable X11 cursor";
                    };
                  };
                  default = {
                    gtk.enable = true;
                    x11.enable = true;
                  };
                  description = "Options for the \"pointerCursor\" Home Manager module";
                };

                sddmTheme = mkOption {
                  type = themeModule
                    {
                      nameDefault = "gruvbox-sddm-theme";
                      nameDescription = "Name of the sddm theme";
                    }
                    {
                      packageDefault = pkgs.callPackage ../pkgs/gruvbox-sddm-theme.nix { };
                      packageDescription = "sddm theme package";
                    };
                };
              };
          }
        )
      );
    };
  };
}
