{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./floaterm.nix
    ./lsp.nix
    ./lualine.nix
    ./neorg.nix
    ./neo-tree.nix
    ./telescope.nix
    ./which-key.nix
  ];

  plugins = {
    comment.enable = true;
    nvim-autopairs.enable = true;
    treesitter.enable = true;
    trouble.enable = true;
    vimtex.enable = true;
    web-devicons.enable = true;
  };
}
