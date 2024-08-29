{
  flake.nixosModules.printing =
    { config
    , lib
    , ...
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
    };
}
