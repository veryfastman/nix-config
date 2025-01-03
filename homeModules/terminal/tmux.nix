{
  flake.homeModules.tmux =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.tmux;
    in
    {
      options.terminal.tmux.enable = mkEnableOption "Enable Tmux";

      config = mkIf cfg.enable {
        programs.tmux = {
          enable = true;
        };
      };
    };
}
