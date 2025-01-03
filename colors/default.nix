{
  config,
  flake-parts-lib,
  inputs,
  ...
}:
let
  inherit (flake-parts-lib) importApply;
in
{
  imports = map (path: importApply path { inherit config inputs; }) [
    ./module.nix
    ./dracula.nix
    ./onedark.nix
    ./gruvbox.nix
  ];
}
