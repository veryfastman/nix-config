{
  flake.nixosModules.keyd = {
    config,
    lib,
    ...
  }: let
    inherit (lib) mkIf;
    cfg = config.services.keyd;
  in
    mkIf cfg.enable {
      services.keyd.keyboards.default = {
        ids = ["*"];
        settings.main = {
          capslock = "esc";
          esc = "capslock";
        };
      };
    };
}
