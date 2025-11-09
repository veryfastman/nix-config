{
  flake.homeModules.git =
    {
      config,
      lib,
      pkgs,
      ...
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
            user.name = "veryfastman";
            user.email = "dony357@outlook.com";
          };

          # git-credential-oauth.enable = true;
        };
      };
    };
}
