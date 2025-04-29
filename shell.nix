{ inputs, ... }:
{
  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { config, pkgs, ... }:
    {
      devshells.default = {
        devshell.startup.pre-commit.text = config.pre-commit.installationScript;

        packages = [
          "nixos-install-tools"
          "nixos-rebuild"
          "nixfmt-rfc-style"
        ];

        commands = [
          {
            name = "build";
            help = "build the configuration";
            command = "nixos-rebuild build --flake .#$1 --use-remote-sudo";
          }
          {
            name = "testconf";
            help = "test out the configuration without creating a new generation";
            command = "nixos-rebuild test --flake .#$1 --use-remote-sudo";
          }
          {
            name = "switch";
            help = "create a new generation with the configuration";
            command = "nixos-rebuild switch --flake .#$1 --use-remote-sudo";
          }
          {
            name = "boot";
            help = "build and set the configuration as the boot default without switching";
            command = "nixos-rebuild boot --flake .#$1 --use-remote-sudo";
          }
          {
            name = "updatein";
            help = "update the flake inputs";
            command = "nix flake update";
          }
          {
            name = "upgrade";
            help = "initiate a full upgrade of the system, consisting of updating the lockfile and git repo, and subsequently switching to the new system";
            command = "nix flake update && git add . && git commit -m \"nix flake update\" && nixos-rebuild switch --flake .#$1 --use-remote-sudo";
          }
          {
            name = "checks";
            help = "run checks";
            command = "nix flake check --show-trace";
          }
          {
            name = "debugconf";
            help = "drop into a nix repl with the flake preloaded";
            command = ''nix --extra-experimental-features repl-flake ".#$1"'';
          }
          {
            name = "formatconf";
            help = "format the configuration files";
            command = "nix fmt";
          }
          {
            name = "generate-hardware-config";
            help = "generate a hardware configuration file for the current system";
            command = "nixos-generate-config --no-filesystems --show-hardware-config > $1";
          }
        ];
      };
    };
}
