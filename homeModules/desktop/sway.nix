{ ... }:
{
  flake.homeModules.sway =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib)
        mkEnableOption
        mkIf
        mkOption
        mkOptionDefault
        types
        ;
      cfg = config.desktop.sway;
    in
    {
      options.desktop.sway = {
        enable = mkEnableOption "Custom Sway module";
        inputConf = mkOption {
          type = types.attrs;
          default = { };
          description = "Input configuration";
        };
        # startupCommands = {
        #   type = types.listOf types.attrs;
        #   default = [ ];
        #   description = "Commands to be run on startup";
        # };
      };

      config = mkIf cfg.enable {
        home.packages = config.desktop.windowManagerPackages;
        programs.i3status = {
          enable = true;
          general.interval = 1;
          modules = {
            "tztime local".settings.format = "%Y-%m-%d %I:%M";
            "volume master" = {
              enable = true;
              position = 3;
            };
          };
        };
        wayland.windowManager.sway = {
          enable = true;
          config = {
            startup = [
              {
                command = "brightnessctl set 9600";
                always = true;
              }
            ]; # ++ cfg.startupCommands;
            defaultWorkspace = "workspace number 1";
            workspaceLayout = "tabbed";
            modifier = "Mod4";
            left = "h";
            down = "j";
            up = "k";
            right = "l";
            terminal = "${pkgs.alacritty}/bin/alacritty";
            menu = "${pkgs.rofi}/bin/rofi -show drun";
            input = {
              "type:keyboard" = {
                repeat_delay = "210";
                repeat_rate = "110";
                xkb_layout = "us,es";
                xkb_variant = "winkeys,intl";
                xkb_options = "grp:sclk_toggle";
              };
            }
            // cfg.inputConf;
            bars = [
              {
                position = "bottom";
                statusCommand = "${pkgs.i3status}/bin/i3status";
                colors = {
                  statusline = "#ffffff";
                  background = "#000000";
                  inactiveWorkspace = {
                    background = "#00000000";
                    border = "#00000000";
                    text = "#5c5c5c";
                  };
                };
              }
            ];
            window.commands = [
              {
                criteria.title = "OpenGLGame";
                command = "floating enable";
              }
            ];
            keybindings =
              let
                inherit (config.wayland.windowManager.sway.config)
                  modifier
                  menu
                  terminal
                  left
                  right
                  up
                  down
                  ;
              in
              mkOptionDefault {
                "${modifier}+Return" = "exec '${terminal}'";
                "${modifier}+Shift+q" = "kill";
                "${modifier}+d" = "exec '${menu}'";
                "${modifier}+Shift+e" = "exec 'swaymsg exit'";
                "${modifier}+${left}" = "focus left";
                "${modifier}+${down}" = "focus down";
                "${modifier}+${up}" = "focus up";
                "${modifier}+${right}" = "focus right";
                "${modifier}+Left" = "focus left";
                "${modifier}+Down" = "focus down";
                "${modifier}+Up" = "focus up";
                "${modifier}+Right" = "focus right";
                "${modifier}+Shift+${left}" = "move left";
                "${modifier}+Shift+${down}" = "move down";
                "${modifier}+Shift+${up}" = "move up";
                "${modifier}+Shift+${right}" = "move right";
                "${modifier}+Shift+Left" = "move left";
                "${modifier}+Shift+Down" = "move down";
                "${modifier}+Shift+Up" = "move up";
                "${modifier}+Shift+Right" = "move right";
                "${modifier}+1" = "workspace number 1";
                "${modifier}+2" = "workspace number 2";
                "${modifier}+3" = "workspace number 3";
                "${modifier}+4" = "workspace number 4";
                "${modifier}+5" = "workspace number 5";
                "${modifier}+6" = "workspace number 6";
                "${modifier}+7" = "workspace number 7";
                "${modifier}+8" = "workspace number 8";
                "${modifier}+9" = "workspace number 9";
                "${modifier}+0" = "workspace number 10";
                "${modifier}+Shift+1" = "move container to workspace number 1";
                "${modifier}+Shift+2" = "move container to workspace number 2";
                "${modifier}+Shift+3" = "move container to workspace number 3";
                "${modifier}+Shift+4" = "move container to workspace number 4";
                "${modifier}+Shift+5" = "move container to workspace number 5";
                "${modifier}+Shift+6" = "move container to workspace number 6";
                "${modifier}+Shift+7" = "move container to workspace number 7";
                "${modifier}+Shift+8" = "move container to workspace number 8";
                "${modifier}+Shift+9" = "move container to workspace number 9";
                "${modifier}+Shift+0" = "move container to workspace number 10";
                "${modifier}+b" = "splith";
                "${modifier}+v" = "splitv";
                "${modifier}+s" = "layout stacking";
                "${modifier}+w" = "layout tabbed";
                "${modifier}+e" = "layout toggle split";
                "${modifier}+f" = "fullscreen";
                "${modifier}+Shift+space" = "floating toggle";
                "${modifier}+space" = "focus mode_toggle";
                "${modifier}+a" = "focus parent";
                "${modifier}+Shift+minus" = "move scratchpad";
                "${modifier}+minus" = "scratchpad show";
                "${modifier}+r" = "mode \"resize\"";
                "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +1%'";
                "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -1%'";
                "XF86AudioMute" = "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
                "XF86AudioMedia" = "exec 'playerctl play-pause'";
                "XF86AudioPlay" = "exec 'playerctl play-pause'";
                "XF86AudioPrev" = "exec 'playerctl previous'";
                "XF86AudioNext" = "exec 'playerctl next'";
                "XF86MonBrightnessUp" = "exec 'brightnessctl set +2%'";
                "XF86MonBrightnessDown" = "exec 'brightnessctl set 2%-'";

                # Program keybinds
                "${modifier}+Mod1+s" = "exec 'zen -P fun'";
                "${modifier}+Mod1+Shift+s" = "exec 'zen -P school";
                "${modifier}+Mod1+o" =
                  "exec 'obsidian --ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations'";
              };
          };
        };
      };
    };
}
