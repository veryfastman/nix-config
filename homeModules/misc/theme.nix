localFlake: {
  flake.homeModules.theme = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkOption types;
  in {
    options.theme = mkOption {
      type = types.attrs;
      default = localFlake.config.flake.colors.gruvbox;
      description = "Set desktop colorscheme";
    };
  };
}
