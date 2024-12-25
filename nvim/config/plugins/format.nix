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
        clang-format.prepend_args = [ "--style=\"{BasedOnStyle: llvm, IndentWidth: 4}\"" ];
      };
    };
  };
}
