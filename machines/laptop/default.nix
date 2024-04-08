localFlake: {
  lib,
  pkgs,
  ...
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

  home-manager.users.donny = { config, ... }: {
    theme = localFlake.config.flake.colors.gruvbox;

    inherit (config.theme) gtk;
    home.pointerCursor = config.theme.pointerCursor;

    home.packages = with pkgs; [
      ani-cli
      bluetuith
      cava
      cmus
      fastfetch
      fzf
      gimp
      htop
      lazygit
      ncdu
      ripgrep
      streamlink
      trash-cli
      unzip
      yewtube
      yt-dlp
      zip

      (callPackage ../../pkgs/tex.nix {})

      (wrapMpv
        (mpv-unwrapped.override {
          ffmpeg = ffmpeg_6-full;
        })
        {scripts = [mpvScripts.mpris];})
    ];

    desktop = {
      hyprland = {
        enable = true;
        enableAnimations = true;
        enableBlur = true;
	roundBorders.enable = true;
	wallpaperCommands = ["${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallpapers/gruvy_seaside.jpg"];

        extraKeybindings = [
          "SUPER, RETURN, exec, alacritty"
          "SUPER, S, exec, firefox"
          "SUPER, R, exec, rofi -show drun"
          "SUPER SHIFT, R, exec, rofi -show run"
          "SUPER, P, exec, rofimoji"
          "SUPER, E, exec, nemo"
        ];

        windowRules = [
          "float, class:.*"
          "tile, class:^(firefox)\$"
          "tile, class:^(Chromium-browser)\$"
          "tile, class:^(Alacritty)\$"
          "opacity 0.9 0.9, class:^(Alacritty)\$"
        ];
      };
    };

    graphic = {
      rofi.enable = true;

      waybar = {
        enable = true;
	barHeight = 22;
        terminal = "alacritty";
        soundControl = "pavucontrol";

	font = {
	  name = "RobotoMonoNerdFont";
	  size = 9.0;
	};
      };
    };

    misc = {
      firefox.enable = true;
      impermanence.enable = true;
      scripts.enable = true;
      wallpapers.enable = true;
      zathura.enable = true;
    };

    terminal = {
      bash.enable = true;
      direnv.enable = true;
      fish.enable = true;
      git.enable = true;
      nushell.enable = false;
      starship.enable = true;
      yazi.enable = true;
      zellij.enable = true;

      alacritty = {
        enable = true;
	shell = "fish";
        font = {
          name = "JetBrainsMonoNerdFont";
          size = 7.5;
        };
      };
    };
  };

  networking.networkmanager.enable = true;

  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  services.printing.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  sound.mediaKeys.enable = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
