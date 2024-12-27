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
          "libnotify"
        ];

        commands = [
          {
            name = "build";
            help = "Build the configuration";
            command = "nixos-rebuild build --flake .#$1 --use-remote-sudo";
          }
          {
            name = "testconf";
            help = "Test out the configuration without creating a new generation";
            command = "nixos-rebuild test --flake .#$1 --use-remote-sudo";
          }
          {
            name = "switch";
            help = "Create a new generation with the configuration";
            command = "nixos-rebuild switch --flake .#$1 --use-remote-sudo";
          }
          {
            name = "boot";
            help = "Build and set the configuration as the boot default without switching";
            command = "nixos-rebuild boot --flake .#$1 --use-remote-sudo";
          }
          {
            name = "update";
            help = "Update the flake inputs";
            command = "nix flake update";
          }
          {
            name = "checks";
            help = "Run checks";
            command = "nix flake check --show-trace";
          }
          {
            name = "debugconf";
            help = "Drop into a nix repl with the flake preloaded";
            command = ''nix --extra-experimental-features repl-flake ".#$1"'';
          }
          {
            name = "format";
            help = "Format the configuration files";
            command = "nix fmt";
          }
          {
            name = "generate-hardware-config";
            help = "Generate a hardware configuration file for the current system";
            command = "nixos-generate-config --no-filesystems --show-hardware-config > $1";
          }
        ];
      };
    };
}
