{ myLib, ... }:
{
  flake.homeModules.tmux =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.tmux;
    in
    {
      options.terminal.tmux = {
        enable = mkEnableOption "Enable Tmux";
        shell = myLib.commonOptions.shell "Tmux";
      };

      config = mkIf cfg.enable {
        programs.tmux = {
          enable = true;
          prefix = "C-a";
          keyMode = "vi";
          baseIndex = 1;
          escapeTime = 10;
          plugins = with pkgs; [
            tmuxPlugins.pain-control
          ];
          inherit (cfg) shell;

          extraConfig =
            let
              inherit (config.theme.colors) palette;
            in
            # set -g status-style 'bg=#${palette.base02} fg=#${palette.base05}'
            ''
              set -g default-terminal "tmux-256color"
              set -g terminal-overrides ',xterm-256color:Tc'

              bind-key Q kill-session
            '';
        };
      };
    };
}
