localFlake: {
  flake.homeModules.wallpapers =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.wallpapers;
    in
    {
      options.misc.wallpapers.enable = mkEnableOption "Enable my collection of wallpapers";

      config = mkIf cfg.enable {
        home.file."Pictures/wallpapers" = {
          source = localFlake.inputs.wallpaper-collection;
          recursive = true;
        };
      };
    };
}
