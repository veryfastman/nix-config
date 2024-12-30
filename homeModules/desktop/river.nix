{ myLib, ... }:
{
  flake.homeModules.river =
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
        types
        ;
      inherit (myLib) createListOfStringsOption;
      cfg = config.desktop.river;
    in
    {
      options.desktop.river = {
        enable = mkEnableOption "Enable River";
        startupCommands = createListOfStringsOption "Commands to be automatically executed when River launches";
        extraCustomConfig = mkOption {
          type = types.str;
          default = "";
          description = "Extra configuration to be added (e.g. keybindings, window rules)";
        };
      };

      config = mkIf cfg.enable {
        home.packages = config.desktop.windowManagerPackages;
        graphic.waybar.wmModules = [
          "river/tags"
          "river/window"
        ];
        wayland.windowManager.river = {
          enable = true;
          # settings =
          #   let
          #     inherit (config.theme.colors.palette) base00 base0D;
          #   in
          #   {
          #     spawn = cfg.startupCommands;
          #
          #     map = {
          #       normal = {
          #         "Super Return" = "spawn alacritty";
          #         "Super W" = "close";
          #         "Super+Control Q" = "exit";
          #         "Super J" = "focus-view next";
          #         "Super K" = "focus-view previous";
          #         "Super+Control J" = "focus-output next";
          #         "Super+Control K" = "focus-output previous";
          #         "Super+Shift J" = "swap next";
          #         "Super+Shift K" = "swap previous";
          #         "Super+Control+Shift J" = "send-to-output next";
          #         "Super+Control+Shift K" = "send-to-output previous";
          #         "Super+Shift Return" = "zoom";
          #         "Super+Shift H" = "send-layout-cmd rivertile \"main-count +1\"";
          #         "Super+Shift L" = "send-layout-cmd rivertile \"main-count -1\"";
          #         "Super+Alt+Control H" = "snap left";
          #         "Super+Alt+Control J" = "snap down";
          #         "Super+Alt+Control K" = "snap up";
          #         "Super+Alt+Control L" = "snap right";
          #         "Super F" = "toggle-float";
          #         "Super M" = "toggle-fullscreen";
          #         "Super Up" = "send-layout-cmd rivertile \"main-location top\"";
          #         "Super Right" = "send-layout-cmd rivertile \"main-location right\"";
          #         "Super Down" = "send-layout-cmd rivertile \"main-location bottom\"";
          #         "Super Left" = "send-layout-cmd rivertile \"main-location left\"";
          #         "Super R" = "spawn \"rofi -show drun\"";
          #         "Super P" = "spawn rofimoji";
          #         "Super+Control I" = "spawn \"bookmark-type\"";
          #         "Super I" = "spawn \"grim -g $(slurp)\"";
          #         "Super S" = "spawn firefox";
          #         "Super+Shift S" = "spawn \"firefox -p\"";
          #         "Super+Control R" = "\"killall waybar && ~/.config/river/init\"";
          #         "Super+Shift C" = "\"alacritty -e nvim ~/.config/river/init\"";
          #       };
          #
          #       "-repeat".normal = {
          #         "Super H" = "send-layout-cmd rivertile \"main-ratio -0.05\"";
          #         "Super L" = "send-layout-cmd rivertile \"main-ratio +0.05\"";
          #         "None XF86AudioRaiseVolume" = "spawn \"pactl set-sink-volume @DEFAULT_SINK@ +1%\"";
          #         "None XF86AudioLowerVolume" = "spawn \"pactl set-sink-volume @DEFAULT_SINK@ -1%\"";
          #         "None XF86AudioMute" = "spawn \"pactl set-sink-mute @DEFAULT_SINK@ toggle\"";
          #         "None XF86AudioMedia" = "spawn \"playerctl play-pause\"";
          #         "None XF86AudioPlay" = "spawn \"playerctl play-pause\"";
          #         "None XF86AudioPrev" = "spawn \"playerctl previous\"";
          #         "None XF86AudioNext" = "spawn \"playerctl next\"";
          #         "None XF86MonBrightnessUp" = "spawn \"brightnessctl set +2%\"";
          #         "None XF86MonBrightnessDown" = "spawn \"brightnessctl set 2%-\"";
          #       };
          #     };
          #
          #     background-color = "0x${lib.toUpper base00}";
          #     border-width = 1;
          #     border-color-focused = "0x${lib.toUpper base0D}";
          #     border-colors-unfocused = "0x${lib.toUpper base00}";
          #     focus-follows-cursor = "normal";
          #     set-cursor-warp = "on-focus-change";
          #     set-repeat = "110 210";
          #     default-layout = "rivertile";
          #     input."pointer-2-14-ETPS/2_Elantech_Touchpad".tap = true;
          #   };
          #
          # extraConfig = ''
          #   all_tags=$(((1 << 32) - 1))
          #   riverctl map normal Super 0 set-focused-tags $all_tags
          #   riverctl map normal Super+Shift 0 set-view-tags $all_tags
          #
          #   for i in $(seq 1 9)
          #   do
          #       tags=$((1 << ($i - 1)))
          #       riverctl map normal Super $i set-focused-tags $tags
          #       riverctl map normal Super+Shift $i set-view-tags $tags
          #       riverctl map normal Super+Control $i toggle-focused-tags $tags
          #       riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
          #   done
          #
          #   riverctl map-pointer normal Super BTN_LEFT move-view
          #   riverctl map-pointer normal Super BTN_RIGHT resize-view
          #   rivertile -view-padding 4 -outer-padding 0 -main-ratio 0.5 &
          #   riverctl map normal Super grave toggle-focused-tags $((1 << 20))
          #   riverctl map normal Super C set-view-tags $((1 << 20))
          #   riverctl spawn-tagmask $(( ((1 << 32) - 1) ^ $((1 << 20)) ))
          # '';

          settings.spawn = cfg.startupCommands;

          extraConfig =
            let
              inherit (config.theme.colors.palette) base00 base0D;
            in
            ''
              riverctl map normal Super Q close
              riverctl map normal Super+Control Q exit
              riverctl map normal Super J focus-view next
              riverctl map normal Super K focus-view previous
              riverctl map normal Super+Control J focus-output next
              riverctl map normal Super+Control K focus-output previous
              riverctl map normal Super+Shift J swap next
              riverctl map normal Super+Shift K swap previous
              riverctl map normal Super+Control+Shift J send-to-output next
              riverctl map normal Super+Control+Shift K send-to-output previous
              riverctl map normal Super+Shift Return zoom

              riverctl map -repeat normal Super H send-layout-cmd rivertile "main-ratio -0.05"
              riverctl map -repeat normal Super L send-layout-cmd rivertile "main-ratio +0.05"
              riverctl map normal Super+Shift H send-layout-cmd rivertile "main-count +1"
              riverctl map normal Super+Shift L send-layout-cmd rivertile "main-count -1"
              riverctl map -repeat normal Super+Alt H move left 100
              riverctl map -repeat normal Super+Alt J move down 100
              riverctl map -repeat normal Super+Alt K move up 100
              riverctl map -repeat normal Super+Alt L move right 100
              riverctl map normal Super+Alt+Control H snap left
              riverctl map normal Super+Alt+Control J snap down
              riverctl map normal Super+Alt+Control K snap up
              riverctl map normal Super+Alt+Control L snap right
              riverctl map -repeat normal Super+Alt+Shift H resize horizontal -100
              riverctl map -repeat normal Super+Alt+Shift J resize vertical 100
              riverctl map -repeat normal Super+Alt+Shift K resize vertical -100
              riverctl map -repeat normal Super+Alt+Shift L resize horizontal 100
              riverctl map-pointer normal Super BTN_LEFT move-view
              riverctl map-pointer normal Super BTN_RIGHT resize-view
              riverctl map normal Super F toggle-float
              riverctl map normal Super M toggle-fullscreen

              for i in $(seq 1 9)
              do
                  tags=$((1 << ($i - 1)))
                  riverctl map normal Super $i set-focused-tags $tags
                  riverctl map normal Super+Shift $i set-view-tags $tags
                  riverctl map normal Super+Control $i toggle-focused-tags $tags
                  riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
              done

              all_tags=$(((1 << 32) - 1))
              riverctl map normal Super 0 set-focused-tags $all_tags
              riverctl map normal Super+Shift 0 set-view-tags $all_tags

              riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
              riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
              riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
              riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

              for mode in normal
              do
                  riverctl map -repeat $mode None XF86AudioRaiseVolume  spawn 'pactl set-sink-volume @DEFAULT_SINK@ +1%'
                  riverctl map -repeat $mode None XF86AudioLowerVolume  spawn 'pactl set-sink-volume @DEFAULT_SINK@ -1%'
                  riverctl map -repeat $mode None XF86AudioMute         spawn 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
                  riverctl map -repeat $mode None XF86AudioMedia        spawn 'playerctl play-pause'
                  riverctl map -repeat $mode None XF86AudioPlay         spawn 'playerctl play-pause'
                  riverctl map -repeat $mode None XF86AudioPrev         spawn 'playerctl previous'
                  riverctl map -repeat $mode None XF86AudioNext         spawn 'playerctl next'
                  riverctl map -repeat $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +2%'
                  riverctl map -repeat $mode None XF86MonBrightnessDown spawn 'brightnessctl set 2%-'
              done

              riverctl background-color 0x${base00}
              riverctl border-width 1
              riverctl border-color-focused 0x${base0D}
              riverctl border-color-unfocused 0x${base00}

              riverctl focus-follows-cursor normal
              riverctl set-cursor-warp on-focus-change
              riverctl set-repeat 110 210
              riverctl default-layout rivertile
              # rivertile -view-padding 4 -outer-padding 4 -main-ratio 0.5 &
              rivertile -view-padding 0 -outer-padding 0 -main-ratio 0.5 &

              riverctl input pointer-2-14-ETPS/2_Elantech_Touchpad tap enabled

              riverctl map normal Super grave toggle-focused-tags $((1 << 20))
              riverctl map normal Super C set-view-tags $((1 << 20))
              riverctl spawn-tagmask $(( ((1 << 32) - 1) ^ $((1 << 20)) ))

              ${cfg.extraCustomConfig}
              riverctl spawn "brightnessctl set 9600"
            '';
        };
      };
    };
}
