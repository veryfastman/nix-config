{
  config,
  lib,
  flake-parts-lib,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    colors = mkOption {
      type = types.lazyAttrsOf types.unspecified;
      default = {};
      description = "Colors for desktop themes";
    };
  };
}
