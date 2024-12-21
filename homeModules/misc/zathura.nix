{
  flake.homeModules.zathura =
    { config
    , lib
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.zathura;
    in
    {
      options.misc.zathura = {
        enable = mkEnableOption "Enable Zathura";
      };

      config = mkIf cfg.enable {
        programs.zathura = {
          enable = true;
          options =
            let
              inherit (config.theme.colors) palette;
            in
            {
              default-bg = "#${palette.base00}";
              default-fg = "#${palette.base01}";

              inputbar-bg = "#${palette.base00}";
              inputbar-fg = "#${palette.base02}";

              notification-error-bg = "#${palette.base08}";
              notification-error-fg = "#${palette.base00}";

              notification-warning-bg = "#${palette.base08}";
              notification-warning-fg = "#${palette.base00}";

              highlight-color = "#${palette.base0A}";
              highlight-active-color = "#${palette.base0D}";

              completion-highlight-fg = "#${palette.base02}";
              completion-highlight-bg = "#${palette.base0C}";

              completion-bg = "#${palette.base02}";
              completion-fg = "#${palette.base0C}";

              notification-bg = "#${palette.base0B}";
              notification-fg = "#${palette.base00}";

              recolor-lightcolor = "#${palette.base00}";
              recolor-darkcolor = "#${palette.base06}";
              recolor = true;
              recolor-keephue = true;
            };
        };
      };
    };
}
