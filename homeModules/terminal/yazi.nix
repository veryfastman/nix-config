{
  flake.homeModules.yazi =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.yazi;
    in
    {
      options.terminal.yazi.enable = mkEnableOption "Enable Yazi";

      config = mkIf cfg.enable {
        programs.yazi = {
          enable = true;
          settings = {
            manager = {
              show_hidden = true;
            };
          };
        };
      };
    };
}
