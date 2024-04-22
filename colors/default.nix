{ config
, flake-parts-lib
, inputs
, ...
}:
let
  inherit (flake-parts-lib) importApply;
in
{
  imports = map (path: importApply path { inherit inputs; }) [ ./module.nix ./gruvbox.nix ];
}
