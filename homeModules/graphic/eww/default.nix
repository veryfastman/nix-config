{
  flake.homeModules.eww =
    { config, lib, ... }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.graphic.eww;
    in
    {
      options.graphic.eww = {
        enable = mkEnableOption "Enable Elkowar's Wacky Widgets";
      };

      # TODO: Add interoperability with the colors module and eww config
      config = mkIf cfg.enable {
        # docs: https://elkowar.github.io/eww/configuration.html
        programs.eww = {
          enable = true;
          configDir = ./eww_conf;
        };
      };
    };
}
