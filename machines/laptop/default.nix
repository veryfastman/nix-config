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
  impermanence.enable = false;
  services.keyd.enable = true;
  services.pipewire.enable = true;
  fonts.enable = true;

  hardware.bluetooth.enable = true;

  home-manager.users.donny = {
    theme = localFlake.config.flake.colors.gruvbox;

    home.packages = with pkgs; [
      ani-cli
      bluetuith
      cava
      cmus
      fastfetch
      fzf
      gimp
      htop
      ncdu
      ripgrep
      streamlink
      trash-cli
      texlive.combined.scheme-full
      unzip
      yewtube
      yt-dlp
      zip

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
        terminal = "alacritty";
        soundControl = "pavucontrol";
      };
    };

    misc = {
      impermanence.enable = false;
      scripts.enable = true;
      wallpapers.enable = true;
      zathura.enable = true;
    };

    terminal = {
      bash.enable = true;
      direnv.enable = true;
      nushell.enable = true;
      starship.enable = true;
      yazi.enable = true;
      zellij.enable = true;

      alacritty = {
        enable = true;
        font = {
          name = "RobotoMonoNerdFont";
          size = 14.0;
        };
      };
    };
  };

  services.printing.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  sound.mediaKeys.enable = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
