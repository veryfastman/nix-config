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
            nerd-fonts.bigblue-terminal
            nerd-fonts.caskaydia-mono
            nerd-fonts.droid-sans-mono
            nerd-fonts.gohufont
            nerd-fonts.fira-code
            nerd-fonts.hack
            nerd-fonts.inconsolata
            nerd-fonts.iosevka-term
            nerd-fonts.jetbrains-mono
            nerd-fonts.liberation
            nerd-fonts.meslo-lg
            nerd-fonts.noto
            nerd-fonts.roboto-mono
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
