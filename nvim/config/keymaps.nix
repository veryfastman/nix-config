{ myLib, ... }:
let
  myKeymaps = [
    {
      key = "<C-Up>";
      action = "<cmd>resize -2<CR>";
    }
    {
      key = "<C-Down>";
      action = "<cmd>resize +2<CR>";
    }
    {
      key = "<C-Right>";
      action = "<cmd>vertical resize -2<CR>";
    }
    {
      key = "<C-Left>";
      action = "<cmd>vertical resize +2<CR>";
    }
    {
      key = "<C-h>";
      action = "<C-w>h";
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
    }
    {
      key = "tn";
      action = "<cmd>tabnew<CR>";
    }
    {
      key = "th";
      action = "<cmd>bprev<CR>";
    }
    {
      key = "tl";
      action = "<cmd>bnext<CR>";
    }
    {
      key = "td";
      action = "<cmd>bd<CR>";
    }
    {
      key = "<leader>d";
      action = "<cmd>noh<CR>";
    }
    {
      key = "j";
      action = "gj";
    }
    {
      key = "k";
      action = "gk";
    }
  ];
in
{
  globals.mapleader = " ";
  keymaps = myLib.silentNormalKeymappings myKeymaps;
}
