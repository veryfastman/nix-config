localFlake: { lib
            , pkgs
            , ...
            }: {
  imports = [
    ./hardware-configuration.nix
    localFlake.config.flake.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  hardware.graphics.enable = true;
  impermanence.enable = true;
  agenix.enable = false;
  services.keyd.enable = true;
  services.pipewire.enable = true;
  fonts.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    gnupg
    neovim
    nix-prefetch-git
    pulseaudio
    python3
    tree
    wget
  ];

  # services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  home-manager.users.donny = { config, ... }: {
    theme = localFlake.config.flake.themes.gruvbox;

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

      localFlake.self.packages.${pkgs.system}.nvim
      (callPackage ../../pkgs/tex.nix { })

      (mpv-unwrapped.wrapper {
        mpv = (mpv-unwrapped.override {
          ffmpeg = ffmpeg_7-full;
        });
        youtubeSupport = true;
        scripts = [ mpvScripts.mpris ];
      })
    ];

    desktop = {
      hyprland = {
        enable = true;
        enableAnimations = true;
        enableBlur = true;
        blurSize = 10;
        roundBorders.enable = true;
        startupCommands = [
          "${pkgs.swaybg}/bin/swaybg -i ~/Pictures/wallpapers/gruvy_seaside.jpg"
          "${config.services.mako.package}/bin/mako"
        ];

        monitor = [ "eDP-1, 1920x1080@60,0x0,1" ];

        extraKeybindings = [
          "SUPER, RETURN, exec, alacritty"
          "SUPER, S, exec, firefox"
          "SUPER SHIFT, S, exec, firefox -p"
          "SUPER, R, exec, rofi -show drun"
          "SUPER SHIFT, R, exec, rofi -show run"
          "SUPER, P, exec, rofimoji"
          "SUPER, E, exec, pcmanfm"
        ];

        windowRules = [
          "float, class:.*"
          "tile, class:^(firefox)\$"
          "tile, class:^(Chromium-browser)\$"
          "tile, class:^(Alacritty)\$"
          # "opacity 0.9 0.9, class:^(Alacritty)\$"
        ];
      };
    };

    graphic = {
      rofi.enable = true;

      mako = {
        enable = true;
        font = {
          name = "JetBrainsMonoNerdFont";
          size = 10;
        };
      };

      waybar = {
        enable = true;
        barHeight = 30;
        terminal = "alacritty";
        soundControl = "pavucontrol";

        font = {
          name = "JetBrainsMonoNerdFont";
          size = 12.0;
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

    terminal =
      let
        enableAndShell = shell: {
          enable = true;
          inherit shell;
        };
      in
      {
        bash.enable = true;
        direnv.enable = true;
        fish.enable = true;
        git.enable = true;
        nushell.enable = false;
        starship.enable = true;
        yazi.enable = true;
        zellij = enableAndShell "fish";

        alacritty =
          (enableAndShell "fish")
          // {
            font = {
              name = "IosevkaTermNerdFontMono";
              size = 12;
            };
          };
      };
  };

  networking.networkmanager.enable = true;

  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  services.printing.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
