{myLib, ...}: {
  flake.homeModules.hyprland = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption types;
    inherit (myLib) createListOfStringsOption;
    cfg = config.desktop.hyprland;
  in {
    options.desktop.hyprland = {
      enable = mkEnableOption "Enable Hyprland";
      enableAnimations = mkEnableOption "Hyprland animations";
      enableBlur = mkEnableOption "Enable blur transparency";
      extraKeybindings = createListOfStringsOption "Custom Hyprland keybindings";
      windowRules = createListOfStringsOption "Set window rules";
      monitor = createListOfStringsOption "List of monitors to be used";
      startupCommands = createListOfStringsOption "Commands to be automatically executed when Hyprland launches";

      borderSize = mkOption {
        type = types.int;
	default = 1;
	description = "Set the border size of windows";
      };

      roundBorders = {
        enable = mkEnableOption "Enable rounded borders";
        roundingAmount = mkOption {
	  type = types.int;
	  default = 5;
	  description = "Amount of rounding to applied to window borders";
	};
      };
    };

    config = mkIf cfg.enable {
      home.packages = config.desktop.windowManagerPackages;
      graphic.waybar.wmModules = ["hyprland/workspaces" "hyprland/window"];
      wayland.windowManager.hyprland = let
        inherit (config.theme.colors.primary) background;
        inherit (config.theme.colors.normal) blue;
      in {
        enable = true;
        xwayland.enable = true;
        settings = {
          inherit (cfg) monitor;
          gestures.workspace_swipe = true;
          master.mfact = 0.5;
          misc.force_default_wallpaper = 0;
          windowrulev2 = cfg.windowRules;

          exec-once =
            [
              (mkIf config.graphic.waybar.enable "waybar")
            ]
            ++ cfg.startupCommands;

          input = {
            follow_mouse = 1;
            repeat_delay = 210;
            repeat_rate = 110;
            numlock_by_default = 1;
            accel_profile = "flat";
          };

          general = {
            gaps_in = 6;
            gaps_out = 8;
            border_size = cfg.borderSize;
            "col.inactive_border" = "rgb(${background})";
            "col.active_border" = "rgb(${blue})";
            layout = "master";
          };

          decoration = {
            rounding = mkIf cfg.roundBorders.enable cfg.roundBorders.roundingAmount;
            blur = {
              enabled = cfg.enableBlur;
              size = 5;
              passes = 1;
              new_optimizations = true;
            };
          };

          bind =
            [
              "SUPER, W, killactive"
              "SUPER CTRL, Q, exit"

              "SUPER, F, togglefloating"
              "SUPER, M, fullscreen"

              "SUPER, h, movefocus,l"
              "SUPER, l, movefocus,r"
              "SUPER, k, movefocus,u"
              "SUPER, j, movefocus,d"
              "SUPER SHIFT, H, movewindow, l"
              "SUPER SHIFT, L, movewindow, r"
              "SUPER SHIFT, K, movewindow, u"
              "SUPER SHIFT, J, movewindow, d"
              "SUPER CTRL, H, resizeactive, -100 0"
              "SUPER CTRL, L, resizeactive, 100 0"
              "SUPER CTRL, K, resizeactive, 0 -100"
              "SUPER CTRL, J, resizeactive, 0 100"

              "SUPER $mainMod, 1, workspace, 1"
              "SUPER $mainMod, 2, workspace, 2"
              "SUPER $mainMod, 3, workspace, 3"
              "SUPER $mainMod, 4, workspace, 4"
              "SUPER $mainMod, 5, workspace, 5"
              "SUPER $mainMod, 6, workspace, 6"
              "SUPER $mainMod, 7, workspace, 7"
              "SUPER $mainMod, 8, workspace, 8"
              "SUPER $mainMod, 9, workspace, 9"
              "SUPER $mainMod, 0, workspace, 10"
              "SUPER $mainMod SHIFT, 1, movetoworkspace, 1"
              "SUPER $mainMod SHIFT, 2, movetoworkspace, 2"
              "SUPER $mainMod SHIFT, 3, movetoworkspace, 3"
              "SUPER $mainMod SHIFT, 4, movetoworkspace, 4"
              "SUPER $mainMod SHIFT, 5, movetoworkspace, 5"
              "SUPER $mainMod SHIFT, 6, movetoworkspace, 6"
              "SUPER $mainMod SHIFT, 7, movetoworkspace, 7"
              "SUPER $mainMod SHIFT, 8, movetoworkspace, 8"
              "SUPER $mainMod SHIFT, 9, movetoworkspace, 9"
              "SUPER $mainMod SHIFT, 0, movetoworkspace, 10"
              "SUPER $mainMod, c, movetoworkspacesilent, special"
              "SUPER $mainMod, grave, togglespecialworkspace"
            ]
            ++ cfg.extraKeybindings;

          binde = [
            ", xf86audioraisevolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +1%"
            ", xf86audiolowervolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -1%"
            ", xf86audiomute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
            ", xf86audioplay, exec, playerctl play-pause"
            ", xf86audionext, exec, playerctl next"
            ", xf86audioprev, exec, playerctl previous"
            ", xf86monbrightnessup, exec, brightnessctl set +2%"
            ", xf86monbrightnessdown, exec, brightnessctl set 2%-"
          ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          animations = {
            enabled = cfg.enableAnimations;
            animation = [
              "workspaces, 1, 3, default"
              "windows, 1, 5, default"
              "fade, 1, 5, default"
            ];
          };
        };
      };
    };
  };
}
