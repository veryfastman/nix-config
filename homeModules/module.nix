{ lib
, flake-parts-lib
, ...
}:
let
  inherit (lib) mkOption types;
in
{
  options.flake = flake-parts-lib.mkSubmoduleOptions {
    homeModules = mkOption {
      type = types.lazyAttrsOf types.unspecified;
      default = { };
      description = "Home manager modules";
    };
  };
}
