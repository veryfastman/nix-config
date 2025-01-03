{
  flake.homeModules.scripts =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.scripts;
    in
    {
      options.misc.scripts.enable = mkEnableOption "Enable shell scripts";

      config = mkIf cfg.enable {
        home.file."~/.local/bin/getvol" = {
          text = ''
            #!/bin/sh

            pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'
          '';
          executable = true;
        };
      };
    };
}
