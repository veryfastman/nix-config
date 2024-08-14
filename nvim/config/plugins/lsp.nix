{
  plugins.lsp = {
    enable = true;

    keymaps.lspBuf = {
      K = {
        action = "hover";
        desc = "Show documentation";
      };
      gd = {
        action = "definition";
        desc = "Goto definition";
      };
      gD = {
        action = "declaration";
        desc = "Goto declaration";
      };
      gi = {
        action = "implementation";
        desc = "Goto implementation";
      };
      gr = {
        action = "references";
        desc = "Show references";
      };
      gt = {
        action = "type_definition";
        desc = "Goto type definition";
      };
      ga = {
        action = "code_action";
        desc = "Show code actions";
      };
    };

    servers = {
      bashls.enable = true;
      # java-language-server.enable = true;
      lua-ls.enable = true;
      nil-ls.enable = true;
      ccls.enable = true;
      # gopls.enable = true;
      # tsserver.enable = true;
      # zls.enable = true;
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };
}
