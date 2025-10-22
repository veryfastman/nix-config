localFlake:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.desktop.niri;
in
{
  options.desktop.niri.enable = mkEnableOption "Niri, a scrollable tiling window manager.";

  config = mkIf cfg.enable {
    home.packages = config.desktop.windowManagerPackages;
    programs.niri = {
      package = pkgs.niri-unstable;
      settings = {
        input = {
          keyboard = {
            repeat-delay = 210;
            repeat-rate = 110;
          };
        };

        outputs = {
          "eDP-1" = {
            # transform = "normal";
          };
        };

        layout = {
          gaps = 16;
          center-focused-column = "never";
          focus-ring = {
            width = 4;
          };
          border = {
            enable = true;
            width = 4;
          };
          preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
          ];
          default-column-width = {
            proportion = 0.8;
          };
          struts = { };
        };

        spawn-at-startup = [
          # { command = [ "${pkgs.xwayland-satellite}" ]; }
          { command = [ "waybar" ]; }
        ];

        environment = {
          OBSIDIAN_USE_WAYLAND = "1";
          electron_ozone_platform_hint = "auto";
        };

        cursor = { };

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        hotkey-overlay = { };

        animations = { };

        window-rules = [
          {
            matches = [
              {
                app-id = ''^org\.wezfurlong\.wezterm$'';
              }
            ];
            default-column-width = { };
          }
        ];

        binds = with config.lib.niri.actions; {
          "Mod+Q".action = close-window;

          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;
          "Mod+Ctrl+Left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;
          "Mod+Home".action = focus-column-first;
          "Mod+End".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;
          "Mod+Shift+Left".action = focus-monitor-left;
          "Mod+Shift+Down".action = focus-monitor-down;
          "Mod+Shift+Up".action = focus-monitor-up;
          "Mod+Shift+Right".action = focus-monitor-right;
          "Mod+Shift+H".action = focus-monitor-left;
          "Mod+Shift+J".action = focus-monitor-down;
          "Mod+Shift+K".action = focus-monitor-up;
          "Mod+Shift+L".action = focus-monitor-right;
          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
          "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+U".action = focus-workspace-down;
          "Mod+I".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Ctrl+U".action = move-column-to-workspace-down;
          "Mod+Ctrl+I".action = move-column-to-workspace-up;
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;
          "Mod+Shift+U".action = move-workspace-down;
          "Mod+Shift+I".action = move-workspace-up;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;
          "Mod+R".action = switch-preset-column-width;
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;
          "Print".action = screenshot;
          # "Ctrl+Print".action = screenshot-screen;
          # "Alt+Print".action = screenshot-window;
          "Mod+Shift+E".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Shift+1".action.move-column-to-workspace = 1;
          "Mod+Shift+2".action.move-column-to-workspace = 2;
          "Mod+Shift+3".action.move-column-to-workspace = 3;
          "Mod+Shift+4".action.move-column-to-workspace = 4;
          "Mod+Shift+5".action.move-column-to-workspace = 5;
          "Mod+Shift+6".action.move-column-to-workspace = 6;
          "Mod+Shift+7".action.move-column-to-workspace = 7;
          "Mod+Shift+8".action.move-column-to-workspace = 8;
          "Mod+Shift+9".action.move-column-to-workspace = 9;

          "Mod+Shift+Slash".action = show-hotkey-overlay;
          "Mod+Return".action = spawn "alacritty";
          "Mod+D".action = spawn "rofi" "-show" "drun";
          "Mod+S".action = spawn "firefox" "-p" "fun";
          "Mod+Shift+S".action = spawn "firefox" "-p" "school";
          "Mod+O".action = spawn "obsidian" "-enable-features=UseOzonePlatform" "-ozone-platform=wayland";

          "XF86AudioRaiseVolume".action = spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "+1%";
          "XF86AudioLowerVolume".action = spawn "pactl" "set-sink-volume" "@DEFAULT_SINK@" "-1%";
          "XF86AudioMute".action = spawn "pactl" "set-sink-mute" "@DEFAULT_SINK@" "toggle";
          "XF86AudioMedia".action = spawn "playerctl" "play-pause";
          "XF86AudioPlay".action = spawn "playerctl" "play-pause";
          "XF86AudioPrev".action = spawn "playerctl" "previous";
          "XF86AudioNext".action = spawn "playerctl" "next";
          "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "+2%";
          "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "2%-";
        };

        debug = { };
      };
    };
  };
}
