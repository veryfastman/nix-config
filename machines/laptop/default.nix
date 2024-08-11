localFlake: { lib
            , pkgs
            , inputs
            }: {
  imports = [
    ./hardware-configuration.nix
    localFlake.config.flake.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  hardware.opengl.enable = true;
  impermanence.enable = true;
  services.keyd.enable = true;
  services.pipewire.enable = true;
  fonts.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    neovim
    nix-prefetch-git
    pulseaudio
    python3
    tree
    wget
  ];

  services.xserver.windowManager.dwm.enable = true;

  networking.networkmanager.enable = true;

  nixpkgs.overlays = [ localFlake.inputs.dwm.overlays ];

  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  services.printing.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  sound.mediaKeys.enable = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
