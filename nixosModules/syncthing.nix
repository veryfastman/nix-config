{
  flake.nixosModules.syncthing =
  { config, lib, pkgs, ... }:
  let
    inherit (lib) mkIf mkOption types;
    cfg = config.services.syncthing;
  in {
    options.services.syncthing = {
      user = mkOption {
        type = types.str;
        default = "donny";
        description = "User using Syncthing";
      };

      deviceList = mkOption {
        type = types.nullOr (types.listOf types.submodule {
          options = {
            name = mkOption {
              type = types.str;
              default = "";
              desc = "Name of device";
            };

            id = mkOption {
              type = types.str;
              default = "";
              desc = "ID of device";
            };
          };
        });
      };
    };

    config = mkIf cfg.enable {
      services.syncthing = {
        inherit (cfg) user;
        dataDir = "/home/${cfg.user}/Sync";
        configDir = "/home/${cfg.user}/Sync/.config/syncthing";
        settings = {
          # devices = map (x: x.name = { id = x.id }) cfg.deviceList;
        };
      };
    };
  };
}
