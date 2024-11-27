localFlake: { config, ... }:
{
  users.users.donny = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    home = "/home/donny";
    initialPassword = "p";
  };
}
