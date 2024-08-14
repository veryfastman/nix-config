{
  flake.nixosModules.keyd =
    { config
    , lib
    , ...
    }:
    let
      inherit (lib) mkIf;
      cfg = config.services.keyd;
    in
    mkIf cfg.enable {
      # Do backspace+escape+enter if keyd breaks keyboard
      systemd.services.keyd.restartIfChanged = false;
      services.keyd.keyboards.default = {
        ids = [ "*" ];
        settings.main = {
          capslock = "overload(control, esc)";
          esc = "capslock";
        };
      };
    };
}
