{
  flake.homeModules.fish =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.fish;
    in
    {
      options.terminal.fish.enable = mkEnableOption "Enable Fish shell";

      config = mkIf cfg.enable {
        programs.fish = {
          enable = true;

          shellAliases = {
            cb = "cargo build";
            cch = "cargo check";
            cv = "cargo run";
            daudio = "yt-dlp --extract-audio --audio-format mp3";
            dvideo = "yt-dlp -f 'bv*[height=1080]+ba'";
            lg = "lazygit";
            ls = "${pkgs.eza}/bin/eza";
            l = "${pkgs.eza}/bin/eza -la";
            mk = "just build";
            mkr = "just run";
            se = "sudoedit";
            snip = "grim -g $(slurp)";
            strcam = "mpv av://v4l2:/dev/video0 --profile=low-latency --untimed";
          };

          shellInit = ''
            set -U fish_greeting
                   fish_add_path ~/.local/bin
                   export VISUAL=nvim
                   export EDITOR="$VISUAL"
            fish_vi_key_bindings
          '';
        };
      };
    };
}
