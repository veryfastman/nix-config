{
  plugins.telescope = {
    enable = true;
    keymaps = {
      "<leader>b" = {
        action = "buffers";
      };
      "<leader>ff" = {
        action = "find_files hidden=true";
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
