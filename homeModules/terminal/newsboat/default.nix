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
          browser = "\"zen -p school\"";
          reloadThreads = 100;
          extraConfig = ''
            refresh-on-startup yes
            cleanup-on-quit yes

            bind-key h quit
            bind-key j down
            bind-key k up
            bind-key l open
            bind-key H prev-feed
            bind-key L next-feed
            bind-key g home
            bind-key G end
            bind-key SPACE macro-prefix
            bind-key b bookmark

            macro v set browser "setsid -f mpv %u > /dev/null 2>&1" ; open-in-browser ; set browser "zen -p school"
            macro p set browser "zen -p school --private-window %u" ; open-in-browser ; set browser "zen -p school"
          '';
        };
      };
    };
}
