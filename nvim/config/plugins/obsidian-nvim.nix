{
  plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "personal_vault";
          path = "~/Documents/personal_vault";
        }
      ];
      daily_notes.folder = "journal";
      mappings = {
        "<leader>ch" = {
          action = "require('obsidian').util.toggle_checkbox";
          opts = {
            buffer = true;
          };
        };
        gf = {
          action = "require('obsidian').util.gf_passthrough";
          opts = {
            buffer = true;
            expr = true;
            noremap = false;
          };
        };
      };
    };
  };
}
