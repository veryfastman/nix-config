localFlake: { config, ... }:
  {
    imports = [
      localFlake.inputs.agenix.nixosModules.default
    ];

    users.users.donny = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ];
      home = "/home/donny";
      # hashedPasswordFile = config.age.secrets.donnyPassword.path;
      initialPassword = "p";
    };
  }
