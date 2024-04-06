localFlake: {
  flake.homeModules.impermanence = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkEnableOption mkIf;
    cfg = config.misc.impermanence;
  in {
    imports = [
      localFlake.inputs.impermanence.nixosModules.home-manager.impermanence
    ];

    options.misc.impermanence.enable = mkEnableOption "Enable impermanence home module";

    config = mkIf cfg.enable {
      home.persistence."/persist/home/donny" = {
        directories = [
          "Coding"
          "Downloads"
          "Music"
          "Misc"
          "Pictures"
          "Documents"
          "Videos"
          ".gnupg"
          ".ssh"
          ".local/share/keyrings"
          ".local/share/direnv"

          # {
          #   directory = ".local/share/Steam";
          #   method = "symlink";
          # }
        ];

        # files = [
        #   ".screenrc"
        # ];

        allowOther = true;
      };
    };
  };
}
