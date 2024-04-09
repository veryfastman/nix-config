localFlake: {
  flake.homeModules.theme = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption types;
    cfg = config.theme;
  in {
    options.theme = mkOption {
      type = types.attrs;
      default = localFlake.config.flake.colors.gruvbox;
      description = "Set desktop colorscheme";
    };

    config = {
      gtk = cfg.gtk // {enable = true;};
      home.pointerCursor = cfg.pointerCursor;
    };
  };
}
