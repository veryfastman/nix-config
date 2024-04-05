{
  flake.homeModules.zellij = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.terminal.zellij;
  in {
    options.terminal.zellij.enable = mkEnableOption "Enable Zellij";

    config = mkIf cfg.enable {
      programs.zellij = {
        enable = true;
        settings = {
          # default_shell = "nu";
        };
      };
    };
  };
}
