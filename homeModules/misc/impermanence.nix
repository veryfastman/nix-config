localFlake: {
  flake.homeModules.impermanence =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.misc.impermanence;
    in
    {
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
            "Slippi"
            "Sync"
            "Games"
            ".cargo"
            ".config/obsidian"
            ".config/SlippiPlayback"
            ".config/SlippiOnline"
            ".config/Slippi Launcher"
            ".gnupg"
            ".ssh"
            # ".local/share/keyrings"
            # ".local/share/direnv"
            # ".local/share/Trash"
            # ".local/share/fish"
            # ".local/share/nvim"
            ".local/share"
            # ".local/state" This is problematic
            ".mozilla"
            ".wine"
            ".zen"

            # ".local/state/wireplumber"
            # ".local/share/Anki2"
            # ".local/state/nvim"

            # {
            #   directory = ".local/share/Steam";
            #   method = "symlink";
            # }
          ];

          files = [
            ".config/sops/age/keys.txt"
            ".zsh_history"
          ];

          allowOther = true;
        };
      };
    };
}
