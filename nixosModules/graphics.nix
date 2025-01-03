{
  flake.nixosModules.opengl =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkIf;
      cfg = config.hardware.graphics;
    in
    mkIf cfg.enable {
      hardware.graphics.extraPackages = [ pkgs.mesa.drivers ];
    };
}
