localFlake: { config
            , lib
            , flake-parts-lib
            , myLib
            , ...
            }:
let
  inherit (lib) types mkOption;
in
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    themes = mkOption
      {
        default = { };
        description = "Desktop themes";
        type = types.lazyAttrsOf
          (
            types.submodule
              (
                { config, ... }: {
                  options =
                    let
                      pkgs = localFlake.inputs.nixpkgs.legacyPackages.x86_64-linux;

                      createStringOption = default: description:
                        mkOption {
                          type = types.str;
                          inherit default description;
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
                      colors = mkOption {
                        type = types.attrs;
                        default = localFlake.inputs.nix-colors.colorschemes.dracula;
                        description = "Color palette";
                      };

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

                      extraNeovimPlugins =
                        mkOption
                          {
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

                      wallpaper = mkOption {
                        type = types.path;
                        default = (localFlake.inputs.nix-colors.lib.contrib { inherit pkgs; }).nixWallpaperFromScheme {
                          scheme = localFlake.config.flake.nixosConfigurations.laptop.config.home-manager.users.donny.theme.colors;
                          width = 1920;
                          height = 1080;
                          logoScale = 5.0;
                        };
                      };
                      description = "Path to wallpaper";
                    };
                }
              )
          );
      };
  };
}
