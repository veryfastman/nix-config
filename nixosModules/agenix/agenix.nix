localFlake: { config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.agenix;
in
{
  imports = [
    localFlake.inputs.agenix.nixosModules.default
  ];

  options.agenix.enable = mkEnableOption "Enable secrets management";

  config = mkIf cfg.enable {
    environment.systemPackages = [
      localFlake.inputs.agenix.packages."${pkgs.system}".default
    ];

    age.identityPaths = [ "/home/donny/.ssh/id_ed25519.pub" ];

    age.secrets = {
      donnyPassword = {
        file = ./donnyPassword.age;
        owner = "donny";
      };
    };
  };
}
