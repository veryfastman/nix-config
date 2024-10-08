# build a nixos configuration
build CONFIGURATION:
  nixos-rebuild build --flake .#{{CONFIGURATION}}

# test a nixos configuration
test CONFIGURATION:
  nixos-rebuild test --flake .#{{CONFIGURATION}} --use-remote-sudo

# switch to a nixos configuration
switch CONFIGURATION:
  nixos-rebuild switch --flake .#{{CONFIGURATION}} --use-remote-sudo

# build and set a nixos configuration as the boot default for the current system
boot CONFIGURATION:
  nixos-rebuild boot --flake .#{{CONFIGURATION}} --use-remote-sudo

# check the current flake
check:
  nix flake check --show-trace

# drop into a nix repl with the flake preloaded
debug:
  nix --extra-experimental-features repl-flake repl ".#"

# update the lock file
update:
  nix flake update

# update the lock file and switch to the new configuration (Make sure Mako is running for the notification to work)
upgrade CONFIGURATION: update
  just switch {{CONFIGURATION}} && notify-send "Finished switching to the upgraded configuration!"

# generate a hardware configuration file for the current system
generate-hardware-config TARGET_FILE:
  nixos-generate-config --no-filesystems --show-hardware-config > {{TARGET_FILE}}
