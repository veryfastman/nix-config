{
  flake.nixosModules.dolphin =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib) mkIf mkEnableOption;
      cfg = config.dolphinOptimization;
    in
    {
      options.dolphinOptimization.enable = mkEnableOption "Enable settings that optimize Dolphin's capabilities";

      config = mkIf cfg.enable {
        services.udev.packages = [ pkgs.dolphin-emu ];
        boot.extraModulePackages = [
          config.boot.kernelPackages.gcadapter-oc-kmod
        ];

        # to autoload at boot:
        boot.kernelModules = [
          "gcadapter_oc"
        ];
      };
    };
}
