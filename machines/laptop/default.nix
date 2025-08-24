localFlake:
{
  config,
  lib,
  pkgs,
  flake-parts-lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    localFlake.config.flake.nixosModules.default
    localFlake.inputs.slippi.nixosModules.default
    localFlake.inputs.musnix.nixosModules.musnix
  ];

  boot.loader.systemd-boot.enable = true;
  hardware.graphics.enable = true;
  impermanence.enable = true;
  sops.enable = true;
  services.keyd.enable = true;
  services.pipewire.enable = true;
  services.printing.enable = true;
  fonts.enable = true;
  dolphinOptimization.enable = true;

  hardware.bluetooth.enable = true;

  # Real-time audio
  musnix.enable = true;

  nix.settings.trusted-users = [
    "root"
    "donny"
  ];

  # system.autoUpgrade = {
  #   enable = true;
  #   flake = "${localFlake.inputs.self.outPath}#laptop";
  #   flags = [
  #     "--update-input"
  #     "nixpkgs"
  #     "--commit-lock-file"
  #   ];
  # };

  environment.systemPackages = with pkgs; [
    age
    curl
    gcc
    git
    gnupg
    libnotify
    neovim
    nix-prefetch-git
    pulseaudio
    python3
    sops
    tree
    wget
  ];

  programs.niri.enable = true;
  nixpkgs.overlays = [ localFlake.inputs.niri.overlays.niri ];
  # programs.niri.package = pkgs.niri;

  services.displayManager.ly.enable = true;
  programs.hyprland.enable = false;
  programs.river.enable = true;
  programs.sway.enable = true;

  home-manager.users.donny =
    { config, ... }:
    {
      imports = [
        localFlake.inputs.stylix.homeModules.stylix
        localFlake.inputs.niri.homeModules.stylix
        localFlake.inputs.slippi.homeManagerModules.default
        {
          slippi-launcher.isoPath = "/home/donny/Games/Super Smash Bros. Melee (USA) (En,Ja) (Rev 2).iso";
        }
      ];

      # theme = localFlake.config.flake.themes.dracula;

      home.stateVersion = lib.mkDefault "21.11";

      home.packages = with pkgs; [
        ani-cli
        anki
        audacity
        bluetuith
        # cava
        cmus
        dolphin-emu
        fastfetch
        fd
        ffmpeg_6-full
        fzf
        ghostty
        gimp
        htop
        lmms
        ncdu
        obsidian
        obs-studio
        qalculate-qt
        ripgrep
        streamlink
        # texliveFull
        trash-cli
        unzip
        winetricks
        wineWowPackages.waylandFull
        yewtube
        youtube-music
        yt-dlp
        zip
        zotero

        localFlake.inputs.zen-browser.packages."${pkgs.system}".default
        ((localFlake.self.packages.${pkgs.system}.nvim).extend config.lib.stylix.nixvim.config)
        # (callPackage ../../pkgs/tex.nix { })
        # TODO: Fix this
        (writeShellScriptBin "glsearch" ''
          firefox \
              ~/Misc/OpenGL-Refpages/gl4/html/$(ls ~/Misc/OpenGL-Refpages/gl4/html/*.xhtml \
                | xargs -n 1 basename \
                | cut -d "." -f 1 \
                | rofi -dmenu).xhtml
        '')
        (writeShellScriptBin "tp" ''
          if [ -n "$1" ]; then
              SESSION_NAME=$1
          else
              SESSION_NAME="coding"
          fi

          tmux new -d -s "$SESSION_NAME"
          tmux rename-window code
          tmux new-window -n cli
          tmux previous-window
          tmux attach-session -t "$SESSION_NAME"
        '')
      ];

      stylix = {
        enable = true;
        # image = "${localFlake.inputs.wallpaper-collection}/abstract_blue.jpg";
        base16Scheme = "${localFlake.inputs.base16-themes}/base16/gruvbox-dark-hard.yaml";
        # cursor = {
        #   name = "";
        # };
      };

      desktop = {
        hyprland = {
          enable = false;
          enableAnimations = true;
          enableBlur = true;
          blurSize = 10;
          roundBorders.enable = true;
          startupCommands = [
            # "${pkgs.swaybg}/bin/swaybg -i ${config.theme.wallpaper}"
            "${config.services.mako.package}/bin/mako"
          ];

          monitor = [ "eDP-1, 1920x1080@60,0x0,1" ];

          extraKeybindings = [
            "SUPER, RETURN, exec, alacritty"
            "SUPER, S, exec, firefox"
            "SUPER SHIFT, S, exec, firefox -p school"
            "SUPER, R, exec, rofi -show drun"
            "SUPER SHIFT, R, exec, rofi -show run"
            "SUPER, P, exec, rofimoji"
            "SUPER, E, exec, pcmanfm"
            "SUPER, B, exec, firefox https://127.0.0.1:8384"
          ];

          windowRules = [
            "float, class:.*"
            "tile, class:^(firefox)\$"
            "tile, class:^(Chromium-browser)\$"
            "tile, class:^(Alacritty)\$"
            "tile, class:^(org.pwmt.zathura)\$"
            "tile, class:^(obsidian)\$"
            # "opacity 0.9 0.9, class:^(Alacritty)\$"
          ];
        };

        xmonad = {
          enable = false;
        };

        sway = {
          enable = true;
          inputConf."type:touchpad".tap = "enabled";
        };

        niri.enable = true;

        river = {
          enable = true;
          startupCommands = [
            "waybar"
          ];
          extraCustomConfig = ''
            riverctl map normal Super Return spawn alacritty
            riverctl map normal Super R spawn 'rofi -show drun'
            riverctl map normal Super P spawn rofimoji
            riverctl map normal Super I spawn 'grim -g $(slurp)'
            riverctl map normal Super S spawn firefox
            riverctl map normal Super+Shift S spawn 'firefox -p'
            riverctl map normal Super B spawn "firefox https://127.0.0.1:8384"
            riverctl map normal Super+Shift F spawn "firefox \\
              ~/Misc/OpenGL-Refpages/gl4/html/\$(ls ~/Misc/OpenGL-Refpages/gl4/html/*.xhtml \\
                | xargs -n 1 basename \\
                | cut -d "." -f 1 \\
                | rofi -dmenu --case-sensitive).xhtml"
            riverctl map normal Super+Control R ~/.config/river/init

            riverctl rule-add -title "OpenGLGame" float
          '';
        };
      };

      graphic = {
        eww.enable = false;
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
          wmModules = [ "niri/workspaces" ];

          font = {
            name = "JetBrainsMonoNerdFont";
            size = 12.0;
          };
        };
      };

      misc = {
        firefox.enable = true;
        impermanence.enable = true;
        mpv.enable = true;
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
          fish.enable = false;
          git.enable = true;
          lazygit.enable = true;
          newsboat.enable = true;
          nushell.enable = false;
          starship.enable = false;
          yazi.enable = true;
          tmux = enableAndShell "${pkgs.zsh}/bin/zsh";
          # zellij = enableAndShell "zsh";
          zellij.enable = false;
          zsh.enable = true;

          alacritty = (enableAndShell "zsh") // {
            font = {
              name = "ZedMonoNerdFont";
              size = 11.5;
            };
          };
        };
    };

  # TODO: Fix this
  services.syncthing = {
    enable = true;
    user = "donny";
    dataDir = "/home/donny/Sync";
    configDir = "/home/donny/Sync/.config/syncthing";
    settings = {
      devices = {
        "phone" = {
          id = "IXHKWJV-QKEROLG-FUYQ5JH-T3L5JA4-GL2ITBF-XD7XR23-A4HOYPF-E7UYVQG";
        };
      };
      folders = {
        "~/Sync/personal_vault" = {
          devices = [ "phone" ];
          label = "personal_vault";
          id = "yjxtn-hj3q4";
        };
        "~/Sync/journal" = {
          devices = [ "phone" ];
          label = "journal";
          id = "pfmr3-a5ttf";
        };
        "~/Sync/running_log" = {
          devices = [ "phone" ];
          label = "running_log";
          id = "m9nax-aldai";
        };
        "~/Sync/homework_folder" = {
          devices = [ "phone" ];
          label = "homework folder";
          id = "23pmq-ouc3s";
        };
        "~/Sync/books" = {
          devices = [ "phone" ];
          label = "books";
          id = "rnhqo-q5ecc";
        };
        "~/Sync/templates" = {
          devices = [ "phone" ];
          label = "templates";
          id = "atgwt-mawp5";
        };
        "~/Music" = {
          devices = [ "phone" ];
          label = "music";
          id = "mrg45-dnnc3";
        };
      };
    };
  };

  systemd.services.syncthing.after = [
    "multi-user.target"
  ];
  systemd.services.syncthing-init.unitConfig.DefaultDependencies = false;

  networking.networkmanager.enable = true;

  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  services.udisks2.enable = true;
  services.upower.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
