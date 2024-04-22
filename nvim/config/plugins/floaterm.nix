{
  plugins.floaterm.enable = true;
  keymaps = [
    {
      key = "<leader>af";
      action = "<cmd>FloatermNew lazygit<cr>";
    }
    {
      key = "<leader>ay";
      action = "<cmd>FloatermNew yazi<cr>";
    }
  ];
}
