{ lib, myLib, pkgs, ... }: {
  plugins.neorg = {
    enable = true;
    package = pkgs.vimPlugins.neorg;
    modules = {
      "core.completion".config.engine = "nvim-cmp";
      "core.dirman".config.workpaces.neorg = "~/Documents/neorg";
    } // lib.genAttrs [ "core.defaults" "core.concealer" "core.summary" ] (_: { __empty = null; });
  };

  keymaps = myLib.silentNormalKeymappings [
    {
      key = "<leader>nn";
      action = "<cmd>Neorg workspace neorg<CR>";
    }
    {
      key = "<leader>nr";
      action = "<cmd>Neorg return<CR>";
    }
    {
      key = "<leader>njt";
      action = "<cmd>Neorg journal today<CR>";
    }
    {
      key = "<leader>njT";
      action = "<cmd>Neorg journal tomorrow<CR>";
    }
    {
      key = "<leader>njc";
      action = "<cmd>Neorg journal toc<CR>";
    }
    {
      key = "<leader>njv";
      action = "<cmd>Neorg journal template<CR>";
    }
  ];
}
