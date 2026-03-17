localFlake:
{ config, ... }:
{
  sops.secrets.donny_password.neededForUsers = true;
  users.users.donny = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
    ];
    home = "/home/donny";
    hashedPasswordFile = config.sops.secrets.donny_password.path;
  };
}
