{ myLib, ... }:
{
  flake.homeModules.mako =
    { config, lib, ... }:
    let
      inherit (lib)
        mkEnableOption
        mkIf
        mkOption
        types
        ;
      cfg = config.graphic.mako;
    in
    {
      options.graphic.mako = {
        enable = mkEnableOption "Enable Mako";
        extraConfig = mkOption {
          type = types.lines;
          default = "";
          description = "Extra Mako configuration";
        };
        height = mkOption {
          type = types.int;
          default = 100;
          description = "Set the notification height";
        };
        margin = mkOption {
          type = types.str;
          default = "10";
          description = "Set the margin of each edge";
        };
        padding = mkOption {
          type = types.str;
          default = "5";
          description = "Set the padding of each edge";
        };
        timeout = mkOption {
          type = types.int;
          default = 15000;
          description = "Set the notification timeout";
        };
        inherit (myLib.commonOptions) font;
      };

      config = mkIf cfg.enable {
        services.mako =
          # let
          #   inherit (config.theme.colors.palette) base02 base05 base0D;
          # in
          {
            enable = true;
            settings = {
              # font = "${cfg.font.name} ${toString cfg.font.size}";
              defaultTimeout = cfg.timeout;
              borderRadius = config.desktop.hyprland.roundBorders.roundingAmount;
              # backgroundColor = "#${base02}";
              # borderColor = "#${base0D}";
              # textColor = "#${base05}";
              inherit (cfg) margin padding;
            };
          };
      };
    };
}
