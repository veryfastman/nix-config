{
  config,
  flake-parts-lib,
  inputs,
  ...
}: {
  flake.nixosModules.default = {
    imports = with config.flake.nixosModules; [
      fonts
      home-manager
      garbage-collection
      impermanence
      keyd
      location
      opengl
      pipewire
      system-packages
      systemd-boot
      users
    ];

    programs.dconf.enable = true;
    security.polkit.enable = true;
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = ["nix-command" "flakes"];
  };

  flake.nixosModules.home-manager = flake-parts-lib.importApply ./home-manager.nix {inherit config inputs;};

  imports = [
    ./impermanence

    ./fonts.nix
    ./garbage-collection.nix
    ./keyd.nix
    ./location.nix
    ./pipewire.nix
    ./opengl.nix
    ./system-packages.nix
    ./systemd-boot.nix
    ./users.nix
  ];
}
