{
  autoCmd = [
    {
      event = [ "BufEnter" ];
      pattern = "*";
      command = "set formatoptions-=cro";
    }
    {
      event = [ "BufEnter" ];
      pattern = "*";
      command = "setlocal formatoptions-=cro";
    }
    {
      event = [ "BufWritePost" ];
      pattern = "*";
      command = ''%s/\s\+$//e'';
    }
  ];
}
