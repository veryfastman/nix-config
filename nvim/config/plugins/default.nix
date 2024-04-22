{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./lsp.nix
    ./lualine.nix
    ./neo-tree.nix
    ./telescope.nix
  ];

  plugins = {
    comment.enable = true;
    nvim-autopairs.enable = true;
    treesitter.enable = true;
  };
}
