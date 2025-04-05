{
  flake.homeModules.lazygit =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.lazygit;
    in
    {
      options.terminal.lazygit.enable = mkEnableOption "Enable Lazygit";

      config = mkIf cfg.enable {
        programs.lazygit = {
          enable = true;
          settings = {
            disableStartupPopups = true;
          };
        };
      };
    };
}
