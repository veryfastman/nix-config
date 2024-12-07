localFlake: { config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.sops;
in
{
  imports = [
    localFlake.inputs.sops-nix.nixosModules.sops
  ];

  options.sops.enable = mkEnableOption "Enable secrets management via sops-nix";

  config = mkIf cfg.enable
    {
      sops = rec {
        defaultSopsFile = ./../secrets.yaml;
        age = {
          keyFile = "/persist/home/donny/.config/sops/age/keys.txt";
        };
        secrets = lib.genAttrs [ "github_token" "donny_password" ] (_: {
          format = "yaml";
          sopsFile = defaultSopsFile;
        });
      };
    };
}
