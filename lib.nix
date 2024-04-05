{inputs}: let
  inherit (builtins) mapAttrs;
  inherit (inputs.nixpkgs.lib) mkOption types;
in {
  specifyHexFormat = colors: precedingSymbol: mapAttrs (_name: value: mapAttrs (_name: value: precedingSymbol + value) value) colors;
  createListOfStringsOption = description:
    mkOption {
      type = types.listOf types.str;
      default = [];
      inherit description;
    };

  # Should only be used when not able to call moduleWithSystem
  pkgs = inputs.nixpkgs.legacyPackages.x84_64-linux;

  commonOptions = let
    inherit (inputs.nixpkgs.lib) mkOption types;
  in {
    font = {
      name = mkOption {
        type = types.str;
        default = "JetBrainsMonoNerdFont";
        description = "Set the font name";
      };

      size = mkOption {
        type = types.float;
        default = 12.0;
        description = "Set the font size";
      };
    };
  };
}
