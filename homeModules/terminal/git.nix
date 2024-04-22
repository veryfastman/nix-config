{
  flake.homeModules.git =
    { config
    , lib
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.git;
    in
    {
      options.terminal.git.enable = mkEnableOption "Enable Git settings";

      config = mkIf cfg.enable {
        programs.git = {
          enable = true;
          userName = "veryfastman";
          userEmail = "dony357@outlook.com";
        };
      };
    };
}
