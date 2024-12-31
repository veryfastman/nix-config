{ config, lib, ... }:
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
      note_path_func = ''
        function(spec)
          -- Instead of placing an ID as the name of the file, the note name is used.
          -- local path = spec.dir / tostring(spec.id)
          local path = spec.dir / tostring(spec.title)
          return path:with_suffix(".md")
        end
      '';
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

  opts.conceallevel = lib.mkIf config.plugins.obsidian.enable 2;
}
