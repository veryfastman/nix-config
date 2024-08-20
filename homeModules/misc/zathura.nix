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
              inherit (config.theme.normalHexColorFormat.primary) background foreground;
            in
            {
              default-bg = background;
              default-fg = foreground;
            };
        };
      };
    };
}
