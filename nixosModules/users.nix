{
  flake.nixosModules.users = {
    users.users.donny = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      home = "/home/donny";
    };
  };
}
