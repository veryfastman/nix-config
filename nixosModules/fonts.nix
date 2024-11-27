{
  flake.nixosModules.fonts =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      inherit (lib) mkEnableOption mkIf;
      cfg = config.fonts;
    in
    {
      options.fonts.enable = mkEnableOption "Enable custom font settings.";

      config = mkIf cfg.enable {
        fonts = {
          packages = with pkgs; [
            material-design-icons
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
            (nerdfonts.override {
              fonts = [
                "BigBlueTerminal"
                "CascadiaCode"
                "DroidSansMono"
                "Gohu"
                "FiraCode"
                "Hack"
                "Inconsolata"
                "IosevkaTerm"
                "JetBrainsMono"
                "LiberationMono"
                "Meslo"
                "Noto"
                "RobotoMono"
              ];
            })
          ];

          enableDefaultPackages = false;

          fontconfig.defaultFonts = {
            serif = [ "Noto Serif" "Noto Color Emoji" ];
            sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
            monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
            emoji = [ "Noto Color Emoji" ];
          };
        };
      };
    };
}
