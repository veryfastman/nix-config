{inputs}: let
  inherit (builtins) mapAttrs;
  inherit (inputs.nixpkgs.lib) mkOption types;
in {
  specifyHexFormat = colors: precedingSymbol: mapAttrs (_: value: mapAttrs (_: value: precedingSymbol + value) value) colors;
  createListOfStringsOption = description:
    mkOption {
      type = types.listOf types.str;
      default = [];
      inherit description;
    };

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

    shell = program:
      mkOption {
        type = types.str;
        default = "bash";
        description = "Set the default shell for ${program}";
      };
  };
}
