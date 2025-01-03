{
  flake.nixosModules.pipewire =
    {
      config,
      lib,
      ...
    }:
    let
      inherit (lib) mkIf;
      cfg = config.services.pipewire;
    in
    mkIf cfg.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
}
