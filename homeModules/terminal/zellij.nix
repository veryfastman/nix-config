{myLib, ...}: {
  flake.homeModules.zellij = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf mkOption types;
    cfg = config.terminal.zellij;
  in {
    options.terminal.zellij = {
      enable = mkEnableOption "Enable Zellij";
      shell = myLib.commonOptions.shell "Zellij";
    };

    config = mkIf cfg.enable {
      programs.zellij = {
        enable = true;
        settings = {
          default_shell = cfg.shell;
        };
      };
    };
  };
}
