localFlake: {
  config,
  lib,
  flake-parts-lib,
  myLib,
  ...
}: let
  inherit (builtins) concatStringsSep substring;
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
        primary = genAttrs ["alternate-background" "background" "foreground"] (name: createStringOption "000000" "Set the ${name}");
      }
      // genAttrs ["bright" "normal"] (categoryName:
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
            ] (name: createStringOption "000000" ("Color hex value for " + concatStringsSep " " [categoryName name]));
          };
          description = "Colors that are ${categoryName}";
        });
  };

  themeModule = {
    nameDefault,
    nameDescription,
  }: {
    packageDefault,
    packageDescription,
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
in {
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    themes = mkOption {
      default = {};
      description = "Desktop themes";
      type = types.lazyAttrsOf (types.submodule {
        options = let
          inherit (myLib) specifyHexFormat;
          colors = mkOption {
            type = colorLayout;
            default = {};
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
                alternate-background = "282828";
                background = "1D2021";
                foreground = "ebdbb2";
              };
            '';
          };
        in {
          inherit colors;

          alacrittyCompatibleColorFormat = mkOption {
            type = colorLayout;
            default = specifyHexFormat (colors // {primary = builtins.removeAttrs colors.primary ["alternate-background"];}) "0x";
            description = "Hex colors that integrate seamlessly with Alacritty";
          };

          normalHexColorFormat = mkOption {
            type = colorLayout;
            default = specifyHexFormat colors "#";
            description = "General purpose hex color codes";
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
                    themeModule {
                      nameDefault = "Gruvbox-Dark-B";
                      nameDescription = "Name of the GTK theme to be used";
                    } {
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
                    themeModule {
                      nameDefault = "Gruvbox-Plus-Dark";
                      nameDescription = "Name of the icon theme to be used";
                    } {
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
        };
      });
    };
  };
}
