{
  flake.homeModules.direnv =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.direnv;
    in
    {
      options.terminal.direnv.enable = mkEnableOption "Enable Direnv";

      config = mkIf cfg.enable {
        programs.direnv = {
          enable = true;
          enableNushellIntegration = true;
          nix-direnv.enable = true;
        };
      };
    };
}
