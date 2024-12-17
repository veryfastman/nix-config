{ lib, myLib, pkgs, ... }: {
  plugins.neorg = {
    enable = false;
    package = pkgs.vimPlugins.neorg;
    settings.load = {
      "core.completion".config.engine = "nvim-cmp";
      "core.dirman".config = {
        workspaces.notes = "~/Documents/notes";
        default_workspace = "notes";
      };
    } // lib.genAttrs [ "core.defaults" "core.concealer" "core.summary" ] (_: { __empty = null; });
  };

  extraPlugins = with pkgs; [
    (vimUtils.buildVimPlugin {
      name = "lua-utils";
      src = fetchFromGitHub {
        owner = "nvim-neorg";
        repo = "lua-utils.nvim";
        rev = "e565749421f4bbb5d2e85e37c3cef9d56553d8bd";
        sha256 = "0bnl2kvxs55l8cjhfpa834bm010n8r4gmsmivjcp548c076msagn";
      };
    })

    (vimUtils.buildVimPlugin {
      name = "pathlib";
      src = fetchFromGitHub {
        owner = "pysan3";
        repo = "pathlib.nvim";
        rev = "d4522df5c845aa5e494eee45205ba8033285bbab";
        sha256 = "1phb7gix9rkmckjhdz1zippyjazjxp1kjzn31kd6dmcp2m0md9gg";
      };
    })

    (vimUtils.buildVimPlugin {
      name = "nio";
      src = fetchFromGitHub {
        owner = "nvim-neotest";
        repo = "nvim-nio";
        rev = "5800f585def265d52f1d8848133217c800bcb25d";
        sha256 = "0y3afl42z41ymksk29al5knasmm9wmqzby860x8zj0i0mfb1q5k5";
      };
    })
  ];

  keymaps = myLib.silentNormalKeymappings [
    {
      key = "<leader>nn";
      action = "<cmd>Neorg workspace notes<CR>";
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
