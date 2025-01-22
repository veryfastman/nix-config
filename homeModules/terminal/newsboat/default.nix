{
  flake.homeModules.newsboat =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.newsboat;
    in
    {
      options.terminal.newsboat.enable = mkEnableOption "A RSS feed reader in the terminal";

      config = mkIf cfg.enable {
        # home.file."~/.config/newsboat/urls".source = ./urls;
        xdg.configFile."newsboat/urls".source = ./urls;

        programs.newsboat = {
          enable = true;
        };
      };
    };
}
