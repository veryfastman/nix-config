{
  plugins.trouble.enable = true;
  keymaps = [
    {
      key = "<leader>t";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      mode = "n";
      options.silent = true;
    }
  ];
}
