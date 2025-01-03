localFlake:
{ config, ... }:
{
  sops.secrets.donny_password.neededForUsers = true;
  users.users.donny = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    home = "/home/donny";
    hashedPasswordFile = config.sops.secrets.donny_password.path;
  };
}
