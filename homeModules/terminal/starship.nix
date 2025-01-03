{
  flake.homeModules.starship =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.starship;
    in
    {
      options.terminal.starship.enable = mkEnableOption "Enable Starship";

      config = mkIf cfg.enable {
        programs.starship = {
          enable = true;
          settings = {
            add_newline = false;
            line_break.disabled = true;
            cmd_duration.disabled = true;
          };
        };
      };
    };
}
