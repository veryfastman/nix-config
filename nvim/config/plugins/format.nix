{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        c = [ "clang_format" ];
        cpp = [ "clang_format" ];
        nix = [ "nixfmt" ];
      };
      formatters = {
        clang_format = {
          command = "clang-format";
          append_args.__raw = "function() return { \"--style={BasedOnStyle: Google, IndentWidth: 4}\" } end";
        };
      };
    };
  };

  autoCmd = [
    {
      event = [ "BufWritePre" ];
      pattern = "*";
      callback.__raw = "function(args) require(\"conform\").format({ bufnr = args.buf }) end";
    }
  ];
}
