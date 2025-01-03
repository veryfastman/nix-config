{ pkgs, ... }:
{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./floaterm.nix
    ./format.nix
    ./lsp.nix
    ./lualine.nix
    ./neorg.nix
    ./neo-tree.nix
    ./obsidian-nvim.nix
    ./telescope.nix
    ./trouble.nix
    ./which-key.nix
  ];

  plugins = {
    comment.enable = true;
    nvim-autopairs.enable = true;
    treesitter.enable = true;
    trouble.enable = true;
    web-devicons.enable = true;

    vimtex = {
      enable = true;
      texlivePackage = pkgs.texliveFull;
      settings.view_method = "zathura";
    };
  };
}
