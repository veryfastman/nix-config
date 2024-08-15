localFlake:
{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (localFlake.config.flake.nixosConfigurations.laptop.config.home-manager.users.donny.theme) sddmTheme;
  cfg = config.services.displayManager.sddm;
in mkIf cfg.enable {
  environment.systemPackages = [ sddmTheme.package ];
  services.displayManager.sddm.theme = sddmTheme.name;
}
