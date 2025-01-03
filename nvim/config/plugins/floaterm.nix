{ myLib, ... }:
{
  plugins.floaterm.enable = true;
  keymaps = myLib.silentNormalKeymappings [
    {
      key = "<leader>af";
      action = "<cmd>FloatermNew --height=40 --width=180 lazygit<cr>";
    }
    {
      key = "<leader>ay";
      action = "<cmd>FloatermNew --height=40 --width=175 yazi<cr>";
    }
  ];
}
