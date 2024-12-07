{ myLib, ... }: {
  flake.homeModules.waybar =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf mkOption types;
      cfg = config.graphic.waybar;
      createNullOrStringOption = description:
        mkOption {
          type = types.nullOr types.str;
          default = null;
          inherit description;
        };
    in
    {
      options.graphic.waybar = {
        enable = mkEnableOption "Enable Waybar";
        terminal = createNullOrStringOption "Terminal for clickable modules to use";
        soundControl = createNullOrStringOption "Sound control program for clickable modules to use";
        wmModules = myLib.createListOfStringsOption "Modules specific to the current compositor";

        barHeight = mkOption {
          type = types.int;
          default = 15;
          description = "Waybar height";
        };

        barPosition = mkOption {
          type = types.str;
          default = "top";
          description = "Bar position on the screen";
        };

        inherit (myLib.commonOptions) font;
      };

      config = mkIf cfg.enable {
        programs.waybar = {
          enable = true;
          settings = {
            mainBar = {
              layer = "top";
              position = cfg.barPosition;
              height = cfg.barHeight;
              output = [ "eDP-1" "HDMI-A-1" ];
              modules-left = cfg.wmModules;
              modules-right = [ "tray" "network" "battery" "disk" "memory" "backlight" "pulseaudio" "clock" ];

              backlight = {
                format = "{icon} {percent}%";
                format-icons = [ "" "" ];
              };

              battery = {
                format = "{icon} ";
                format-alt = "{icon} {capacity}%";
                format-icons = [ " " " " " " " " " " ];
                states = {
                  warning = 30;
                  critical = 10;
                };
              };

              clock = {
                format = " {:%I:%M}";
                format-alt = " {:%m/%d/%Y}";
              };

              disk = {
                format = "󰨣 {percentage_free}%";
                format-alt = "󰨣 {free} free";
                on-click-right = "${pkgs.nemo}/bin/nemo";
                path = "/";
              };

              memory = {
                format = "󰍹 {}%";
                format-alt = "󰍹 {used}GiB";
                on-click-right = "${pkgs.alacritty}/bin/alacritty -e htop";
              };

              network = {
                format = "{icon}";
                format-alt = "{essid} ({signalStrength}%) {icon}";
                format-icons = [ "󰤯" "󰤟" "󰤢" "󰤢" "󰤨" ];
                on-click-right = "${pkgs.alacritty}/bin/alacritty -e nmcli";
              };

              pulseaudio = {
                format = "{icon} {volume}%";
                format-alt = "{icon} {description}";
                format-bluetooth = "{icon}󰂯 {volume}%";
                format-muted = "󰝟";
                format-icons = {
                  default = [ "" "" ];
                };
                on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
              };

              river.tags = {
                num-tags = 9;
                tag-labels = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" ];
              };
            };
          };
          style =
            let
              inherit (config.theme.palette) base00 base05 base0D base0B;
              inherit (cfg) font;
            in
            ''
              * {
                background: #${base00};
                border: none;
                border-radius: 0;
                color: #${base05};
                font-family: ${font.name};
                font-size: ${toString font.size}px;
                margin: 0;
                padding: 0;
              }

              #backlight,
              #clock,
              #disk,
              #memory,
              #pulseaudio,
              #tray,
              #window {
                margin-right: 8px;
                margin-left: 8px;
              }

              #tags button {
                margin: -10px;
              }

              #battery,
              #network {
                margin-right: 5px;
                margin-left: 5px;
                font-size: ${toString (font.size + 2)}px;
              }

              #tags button.occupied label {
                color: #${base0B};
              }

              #tags button.focused label {
                color: #${base0D};
              }

              #workspaces {
               margin-left: 4px;
              }

              #workspaces button.active label {
                color: #${base0D};
                font-weight: bold;
              }
            '';
        };
      };
    };
}
