{ config, ... }: {
  flake.nixosModules.users = {
    users.users.donny = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      home = "/home/donny";
      # initialPassword = builtins.readFile config.age.secrets.donnyPassword.path;
      initialPassword = "password";
    };
  };
}
