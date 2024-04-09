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
    options.terminal.alacritty = let
      inherit (myLib.commonOptions) font shell;
    in {
      enable = mkEnableOption "Enable Alacritty";
      shell = shell "Alacritty";
      inherit font;
    };

    config.programs.alacritty = mkIf cfg.enable {
      enable = true;
      settings = {
        colors = config.theme.alacrittyCompatible;
        shell.program = cfg.shell;

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
