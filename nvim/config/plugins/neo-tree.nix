{ myLib, ... }:
{
  plugins.neo-tree = {
    enable = true;
    settings = {
      window.position = "right";
    };
  };

  keymaps = myLib.silentNormalKeymappings [
    {
      key = "<leader>e";
      action = "<cmd>Neotree toggle<CR>";
    }
  ];
}
