{
  flake.homeModules.zsh =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.zsh;
    in
    {
      options.terminal.zsh = {
        enable = mkEnableOption "Z Shell";
      };

      config = mkIf cfg.enable {
        programs.zsh = {
          enable = true;
          shellAliases = {
            v = "nvim";
            cb = "cargo build";
            cch = "cargo check";
            cv = "cargo run";
            daudio = "yt-dlp --extract-audio --audio-format mp3";
            dvideo = "yt-dlp -f 'bv*[height=1080]+ba'";
            lg = "lazygit";
            mk = "just build";
            mkr = "just run";
            se = "sudoedit";
            snip = "grim -g (slurp)";
            strcam = "mpv av://v4l2:/dev/video0";
            zh = "zathura";
          };
          sessionVariables = {
            EDITOR = "nvim";
          };
          oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
              "vi-mode"
            ];
          };
        };
      };
    };
}
