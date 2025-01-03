{
  flake.homeModules.bash =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.terminal.bash;
    in
    {
      options.terminal.bash.enable = mkEnableOption "Enable Bash";

      config = mkIf cfg.enable {
        programs.bash = {
          enable = true;
          enableCompletion = true;

          bashrcExtra = ''
            export PATH="$PATH:$HOME/.local/bin"
          '';

          shellAliases = {
            ls = "ls --color";
            grep = "grep --color=auto";
            v = "nvim";
            re = "sudo reboot";
            pow = "sudo poweroff";
          };
        };
      };
    };
}
