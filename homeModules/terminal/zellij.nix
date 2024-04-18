{myLib, ...}: {
  flake.homeModules.zellij = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption types;
    cfg = config.terminal.zellij;
  in {
    options.terminal.zellij = {
      enable = mkEnableOption "Enable Zellij";
      shell = myLib.commonOptions.shell "Zellij";
    };

    config = mkIf cfg.enable {
      programs.zellij = {
        enable = true;
        settings = {
          default_shell = cfg.shell;
          default_layout = "compact";
          pane_frames = false;
          theme = "my-theme";

          themes = {
            my-theme = let
              inherit (config.theme.normalHexColorFormat) normal;
              inherit (config.theme.normalHexColorFormat.extra) orange;
              inherit (config.theme.normalHexColorFormat.primary) background foreground;
            in
              {
                bg = background;
                fg = foreground;
                orange = orange.normal;
              }
              // normal;
          };
        };
      };
    };
  };
}
