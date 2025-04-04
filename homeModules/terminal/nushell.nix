{
  flake.homeModules.nushell =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.nushell;
    in
    {
      options.terminal.nushell.enable = mkEnableOption "Enable Nushell";

      config = mkIf cfg.enable {
        programs.nushell = {
          enable = true;
          configFile.text = ''
            $env.config = {
              edit_mode: vi,
              show_banner: false,
            }

            $env.PATH = ($env.PATH |
              split row (char esep) |
              append ($env.HOME | path join ".local" "bin")
            )

            $env.SHELL = "nu"
            $env.EDITOR = "nvim"
            $env.VISUAL = $env.EDITOR

            # lamu = (la)zy (mu)sic
            def lamu [name: string] {
              ls ~/Music/**/*
                | where type == file
                | filter {|x| $x.name | str contains $name}
                | get name
                | first
                | mpv $in
            }

            alias v = nvim
            alias cb = cargo build
            alias cch = cargo check
            alias cv = cargo run
            alias daudio = yt-dlp --extract-audio --audio-format mp3
            alias dvideo = yt-dlp -f 'bv*[height=1080]+ba'
            alias lg = lazygit
            alias mk = just build
            alias mkr = just run
            alias se = sudoedit
            alias snip = grim -g (slurp)
            alias strcam = mpv av://v4l2:/dev/video0
            alias zh = zathura

            ${pkgs.carapace}/bin/carapace chmod nushell | ignore
          '';
        };
      };
    };
}
