{
  flake.nixosModules.system-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      curl
      gcc
      git
      neovim
      nix-prefetch-git
      python3
      tree
      vimv
      wget
    ];
  };
}
