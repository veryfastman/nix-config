{ myLib, ... }:
{
  flake.homeModules.zellij =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.zellij;
    in
    {
      options.terminal.zellij = {
        enable = mkEnableOption "Enable Zellij";
        shell = myLib.commonOptions.shell "Zellij";
      };

      config =
        let
          # https://github.com/nix-community/home-manager/issues/4659#issuecomment-2574906923
          zellijBindings =
            bindList:
            lib.attrsets.mergeAttrsList (
              lib.lists.forEach bindList (el: {
                "bind \"${el.key}\"" = el.action;
              })
            );
        in
        mkIf cfg.enable {
          programs.zellij = {
            enable = true;
            settings = {
              default_shell = cfg.shell;
              default_layout = "compact";
              pane_frames = false;
              theme = "my-theme";

              # settings.keybinds.locked = {
              #
              # };

              themes = {
                my-theme =
                  let
                    inherit (config.theme.colors) palette;
                  in
                  {
                    fg = "#${palette.base05}";
                    bg = "#${palette.base02}";
                    black = "#${palette.base00}";
                    red = "#${palette.base08}";
                    green = "#${palette.base0B}";
                    yellow = "#${palette.base0A}";
                    blue = "#${palette.base0D}";
                    magenta = "#${palette.base0E}";
                    cyan = "#${palette.base0C}";
                    white = "#${palette.base05}";
                    orange = "#${palette.base09}";
                  };
              };
            };
          };
        };
    };
}
