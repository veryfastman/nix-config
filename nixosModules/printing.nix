{
  flake.nixosModules.printing =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkIf;
      cfg = config.services.printing;
    in
    mkIf cfg.enable {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };

      services.printing.drivers = [ pkgs.hplipWithPlugin ];
    };
}
