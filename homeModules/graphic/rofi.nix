{myLib, ...}: {
  flake.homeModules.rofi = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption;
    cfg = config.graphic.rofi;
  in {
    options.graphic.rofi = {
      enable = mkEnableOption "Enable Rofi";
      font = myLib.commonOptions.font.name;
    };

    config = mkIf cfg.enable {
      home.packages = [pkgs.rofimoji];

      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        font = cfg.font;
        terminal = mkIf config.terminal.alacritty.enable "${pkgs.alacritty}/bin/alacritty";
        extraConfig = {
          display-drun = "󰀻 ";
          display-run = " ";
          drun-display-format = "{icon} {name}";
          show-icons = true;
          icon-theme = config.theme.gtk.iconTheme.name;
        };
        theme = let
          inherit (config.lib.formats.rasi) mkLiteral;
          inherit (config.theme.normalHexColorFormat.primary) background foreground;
          inherit (config.theme.normalHexColorFormat.extra) alternate-background;
          inherit (config.theme.normalHexColorFormat.normal) blue;
        in {
          "*" = {
            bg = mkLiteral background;
            bg-selected = mkLiteral alternate-background;
            fg = mkLiteral foreground;
            border-color = mkLiteral "@bg-selected";
            border-radius = mkLiteral "0px"; # Maybe later add option for border-radius?
            border = 1;
            margin = 0;
            padding = 0;
            spacing = 0;
          };

          window = {
            background-color = mkLiteral "@bg";
            width = mkLiteral "30%";
          };

          element = {
            padding = mkLiteral "8 12";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@fg";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
            spacing = mkLiteral "10px";
          };

          "element selected" = {
            text-color = mkLiteral blue;
            background-color = mkLiteral "@bg-selected";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          element-text = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          element-icon = {
            size = 25;
            padding = mkLiteral "0 10 0 0";
            background-color = mkLiteral "transparent";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          entry = {
            padding = 12;
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@fg";
            placeholder = "Search";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          inputbar = {
            children = map mkLiteral ["prompt" "entry"];
            background-color = mkLiteral "@bg";
            padding = 5;
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          listview = {
            background-color = mkLiteral "@bg";
            columns = 1;
            lines = 10;
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          mainbox = {
            children = map mkLiteral ["inputbar" "listview"];
            background-color = mkLiteral "@bg";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };

          prompt = {
            enabled = true;
            padding = mkLiteral "12 0 0 12";
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@fg";
            border = mkLiteral "0px solid";
            border-radius = mkLiteral "0px";
          };
        };
      };
    };
  };
}
