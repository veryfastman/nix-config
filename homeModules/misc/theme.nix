localFlake: {
  flake.homeModules.theme =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkOption types;
      cfg = config.theme;
    in
    {
      options.theme = mkOption {
        type = types.attrs;
        default = localFlake.config.flake.themes.dracula;
        description = "Set desktop colorscheme";
      };

      config = rec {
        gtk = {
          enable = true;
          inherit (cfg) cursorTheme iconTheme;
          theme = {
            name = cfg.colors.slug;
            package = (localFlake.inputs.nix-colors.lib.contrib { inherit pkgs; }).gtkThemeFromScheme { scheme = cfg.colors; };
          };
        };
        home.pointerCursor = {
          inherit (gtk.cursorTheme) name package;
          gtk.enable = true;
          x11.enable = true;
        };
      };
    };
}
