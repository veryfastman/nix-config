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
  imports = [ localFlake.inputs.niri.homeModules.niri ];

  options.desktop.niri.enable = mkEnableOption "Niri, a scrollable tiling window manager.";

  config = mkIf cfg.enable {
    programs.niri = {
      package = pkgs.niri-unstable;
      settings = {
        binds = {
          "XF86AudioRaiseVolume".action.spawn = [
            "pactl"
            "set-sink-volume"
            "@DEFAULT_SINK@"
            "+1%"
          ];
          "XF86AudioLowerVolume".action.spawn = [
            "pactl"
            "set-sink-volume"
            "@DEFAULT_SINK@"
            "-1%"
          ];
          "XF86AudioMute".action.spawn = [
            "pactl"
            "set-sink-mute"
            "@DEFAULT_SINK@"
            "toggle"
          ];
          "XF86AudioMedia".action.spawn = [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioPlay".action.spawn = [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioPrev".action.spawn = [
            "playerctl"
            "previous"
          ];
          "XF86AudioNext".action.spawn = [
            "playerctl"
            "next"
          ];
          "XF86MonBrightnessUp".action.spawn = [
            "brightnessctl"
            "set"
            "+2%"
          ];
          "XF86MonBrightnessDown".action.spawn = [
            "brightnessctl"
            "set"
            "2%-"
          ];
        };
      };
    };
  };
}
