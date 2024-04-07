{myLib, ...}: {
  flake.homeModules.alacritty = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption types;
    cfg = config.terminal.alacritty;
  in {
    options.terminal.alacritty = {
      enable = mkEnableOption "Enable Alacritty";
      inherit (myLib.commonOptions) font;
    };

    config.programs.alacritty = mkIf cfg.enable {
      enable = true;
      settings = {
        colors = config.theme.alacrittyCompatible;
        env.TERM = "${pkgs.nushell}/bin/nu";

        font = {
          size = cfg.font.size;
          normal = {
            family = cfg.font.name;
            style = "Normal";
          };
        };
      };
    };
  };
}
