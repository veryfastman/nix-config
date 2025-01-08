{ myLib, ... }:
{
  flake.homeModules.sway =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.desktop.sway;
    in
    {
      options.desktop.sway = {
        enable = mkEnableOption "Custom Sway module";
      };

      config = mkIf cfg.enable {
        home.packages = config.desktop.windowManagerPackages;
        wayland.windowManager.sway = {
          enable = true;
          # TODO: configure settings
        };
      };
    };
}
