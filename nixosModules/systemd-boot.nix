{
  flake.nixosModules.systemd-boot =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkIf;
      cfg = config.boot.loader.systemd-boot;
    in
    mkIf cfg.enable {
      boot.loader.efi.canTouchEfiVariables = true;
    };
}
