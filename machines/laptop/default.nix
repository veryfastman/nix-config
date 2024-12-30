localFlake:
{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    localFlake.config.flake.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  hardware.graphics.enable = true;
  impermanence.enable = true;
  sops.enable = true;
  services.keyd.enable = true;
  services.pipewire.enable = true;
  services.printing.enable = true;
  fonts.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    age
    curl
    gcc
    git
    gnupg
    neovim
    nix-prefetch-git
    pulseaudio
    python3
    sops
    tree
    wget
  ];

  services.displayManager.ly.enable = true;
  programs.hyprland.enable = true;
  programs.river.enable = true;

  home-manager.users.donny =
    { config, ... }:
    {
      theme = localFlake.config.flake.themes.onedark;

      home.stateVersion = lib.mkDefault "21.11";

      home.packages = with pkgs; [
        ani-cli
        bluetuith
        # cava
        cmus
        fastfetch
        fd
        fzf
        gimp
        htop
        lazygit
        ncdu
        obs-studio
        ripgrep
        streamlink
        texliveFull
        trash-cli
        unzip
        winetricks
        wineWowPackages.waylandFull
        yewtube
        yt-dlp
        zip

        localFlake.self.packages.${pkgs.system}.nvim
        # (callPackage ../../pkgs/tex.nix { })
      ];

      desktop = {
        hyprland = {
          enable = true;
          enableAnimations = true;
          enableBlur = true;
          blurSize = 10;
          roundBorders.enable = true;
          startupCommands = [
            "${pkgs.swaybg}/bin/swaybg -i ${config.theme.wallpaper}"
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
            "tile, class:^(org.pwmt.zathura)\$"
            # "opacity 0.9 0.9, class:^(Alacritty)\$"
          ];
        };

        xmonad = {
          enable = false;
        };

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
            riverctl map normal Super+Control R ~/.config/river/init

            riverctl rule-add -title "OpenGLGame" float
          '';
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
          nushell.enable = true;
          starship.enable = true;
          yazi.enable = true;
          zellij = enableAndShell "nu";

          alacritty = (enableAndShell "nu") // {
            font = {
              name = "InconsolataNerdFont";
              size = 12.5;
            };
          };
        };
    };

  services.syncthing = {
    enable = false;
    user = "donny";
    dataDir = "/home/donny/Sync";
    configDir = "/home/donny/Sync/.config/syncthing";
    settings.devices = {
      "phone" = {
        id = "IXHKWJV-QKEROLG-FUYQ5JH-T3L5JA4-GL2ITBF-XD7XR23-A4HOYPF-E7UYVQG";
      };
    };
  };

  networking.networkmanager.enable = true;

  security.sudo.extraConfig = "Defaults lecture=\"never\"";

  services.udisks2.enable = true;
  services.upower.enable = true;

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = lib.trivial.release;
  nixpkgs.hostPlatform = "x86_64-linux";
}
