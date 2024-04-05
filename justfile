# build a nixos configuration
build CONFIGURATION:
  nixos-rebuild build --flake .#{{CONFIGURATION}}

# test a nixos configuration
test CONFIGURATION:
  sudo nixos-rebuild test --flake .#{{CONFIGURATION}}

# switch to a nixos configuration
switch CONFIGURATION:
  sudo nixos-rebuild switch --flake .#{{CONFIGURATION}}

# build and set a nixos configuration as the boot default for the current system
boot CONFIGURATION:
  sudo nixos-rebuild boot --flake .#{{CONFIGURATION}}

# check the current flake
check:
  nix flake check --show-trace

# drop into a nix repl with the flake preloaded
debug:
  nix --extra-experimental-features repl-flake repl ".#"

# generate a hardware configuration file for the current system
generate-hardware-config TARGET_FILE:
  nixos-generate-config --no-filesystems --show-hardware-config > {{TARGET_FILE}}
