# Installation

- First obtain a NixOS ISO and boot into a live environment
    - [NixOS Download](https://nixos.org/download/)
    - [Tutorial for booting a live environment](https://www.linux.com/training-tutorials/live-booting-linux/)

- Most of the commands below require root privileges, so you should probably log in as root user before starting the guide

```
sudo su
```

- Make sure you have a working internet connection. Get started by opening a terminal and cloning this repository

```
nix-shell -p git
git clone https://github.com/veryfastman/nix-config
cd nix-config
```


## Format partitions

(DISCLAIMER: This method only works on UEFI-based devices)

- To format your preferred disk, run this command (WARNING: THIS COMMAND WILL DELETE ALL DATA PRESENT ON SELECTED DISK)

```
# Replace "/dev/your_device" with a device present on your machine.
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix --arg device '"/dev/your_device"'
```

## Move configuration to mounted disk

```
cd ../ # cd into previous directory
mkdir /mnt/etc # Create the etc directory on the disk
mv nix-config /mnt/etc/nixos # Move config to the disk
cd /mnt/etc/nixos # cd back into the config
```

## Create new device configuration

- FYI: You could name rename "your_machine" to whatever you like

```
cd machines # cd into directory holding device-specific configurations
cp -r laptop your_machine # Create new config by duplicating a present one
cd your_machine # cd into new config
nixos-generate-config --show-hardware-config > hardware-configuration.nix # Generate a new hardware config
git add .
```

- Add the new configuration to "/mnt/etc/nixos/machines/default.nix"

```
/mnt/etc/nixos/machines/default.nix

...
flake.nixosConfigurations = {
...
    your_machine = inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.disko.nixosModules.default
        (import ../disko.nix { device = "/dev/your_device"; })
        (flake-parts-lib.importApply ./your_machine { inherit config self; })
      ];
    };
...
}
...
```

## Install

- Copy the config to /mnt/persist so it doesn't get erased by impermanence

```
cd /mnt
cp -r etc/nixos persist/
```

- Install the system and reboot after the installation is finished

```
nixos-install --root /mnt --flake /mnt/etc/nixos#your_machine
reboot
```
