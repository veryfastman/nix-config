{ myLib, ... }:
{
  flake.homeModules.alacritty =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.alacritty;
    in
    {
      options.terminal.alacritty =
        let
          inherit (myLib.commonOptions) font shell;
        in
        {
          enable = mkEnableOption "Enable Alacritty";
          shell = shell "Alacritty";
          inherit font;
        };

      config.programs.alacritty = mkIf cfg.enable {
        enable = true;
        settings = {
          colors =
            let
              inherit (config.theme.colors) palette;
            in
            {
              draw_bold_text_with_bright_colors = false;

              primary = {
                background = "0x${palette.base00}";
                foreground = "0x${palette.base05}";
              };

              cursor = {
                text = "0x${palette.base00}";
                cursor = "0x${palette.base05}";
              };

              normal = {
                black = "0x${palette.base00}";
                red = "0x${palette.base08}";
                green = "0x${palette.base0B}";
                yellow = "0x${palette.base0A}";
                blue = "0x${palette.base0D}";
                magenta = "0x${palette.base0E}";
                cyan = "0x${palette.base0C}";
                white = "0x${palette.base05}";
              };

              bright = {
                black = "0x${palette.base03}";
                red = "0x${palette.base09}";
                green = "0x${palette.base01}";
                yellow = "0x${palette.base02}";
                blue = "0x${palette.base04}";
                magenta = "0x${palette.base06}";
                cyan = "0x${palette.base0F}";
                white = "0x${palette.base07}";
              };
            };

          terminal.shell.program = cfg.shell;

          font = {
            size = cfg.font.size;
            normal = {
              family = cfg.font.name;
              style = "Normal";
            };
          };

          env.TERM = "xterm-256color";

          # cursor = {
          #   style = {
          #     shape = "Underline";
          #     blinking = "Always";
          #   };
          #   blink_interval = 500;
          #   blink_timeout = 0;
          # };
        };
      };
    };
}
