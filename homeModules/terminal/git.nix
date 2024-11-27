{
  flake.homeModules.git =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.git;
    in
    {
      options.terminal.git.enable = mkEnableOption "Enable Git settings";

      config = mkIf cfg.enable {
        programs = {
          git = {
            enable = true;
            package = pkgs.gitFull;
            userName = "veryfastman";
            userEmail = "dony357@outlook.com";
          };

          # git-credential-oauth.enable = true;
        };
      };
    };
}
