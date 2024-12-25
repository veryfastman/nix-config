{ myLib, ... }: {
  flake.homeModules.xmonad =
    { config
    , lib
    , pkgs
    , ...
    }:
    let
      cfg = config.desktop.xmonad;
      inherit (lib) mkEnableOptions mkIf;
    in
    {
      options.desktop.xmonad = {
        enable = mkEnableOptions "Enable Xmonad";
        # windowRules
        # extraKeybindings
      };

      config = mkIf cfg.enable {
        home.packages = config.desktop.xWindowManagerPackages;
        xsession.windowManager.xmonad = {
          enable = true;
          config = pkgs.writeText "xmonad.hs" ''

          '';
        };
      };
    };
}
