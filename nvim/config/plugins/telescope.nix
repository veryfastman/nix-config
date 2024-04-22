{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
      };
      "<leader>fb" = {
        action = "buffers";
      };
      "<leader>fo" = {
        action = "oldfiles";
      };
      "<leader>fc" = {
        action = "colorscheme";
      };
      "<leader>ft" = {
        action = "live_grep";
      };
    };
  };
}
