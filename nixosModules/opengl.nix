{
  flake.nixosModules.opengl = {
    config,
    lib,
    pkgs,
    ...
  }: let
    inherit (lib) mkIf;
    cfg = config.hardware.opengl;
  in
    mkIf cfg.enable {
      hardware.opengl.extraPackages = [pkgs.mesa_drivers];
    };
}
