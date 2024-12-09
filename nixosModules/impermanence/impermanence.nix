localFlake: { config
            , lib
            , ...
            }:
let
  inherit (lib) mkAfter mkEnableOption mkIf;
  cfg = config.impermanence;
in
{
  imports = [
    localFlake.inputs.impermanence.nixosModules.impermanence
  ];

  options.impermanence.enable = mkEnableOption "Enable impermanence";

  config = mkIf cfg.enable {
    boot.initrd.postDeviceCommands = mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';

    fileSystems."/persist".neededForBoot = true;
    programs.fuse.userAllowOther = true;
    environment.etc.machine-id.source = ./machine-id;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/etc/ssh"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/sys/class/backlight/intel_backlight"
        # { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
      ];
      files = [
        # "/etc/machine-id"
        # {
        #   file = "/var/keys/secret_file";
        #   parentDirectory = {mode = "u=rwx,g=,o=";};
        # }
      ];
    };

    systemd.tmpfiles.rules = [
      "d /persist/home/ 0777 root root -"
      "d /persist/home/donny 0700 donny users -"
    ];
  };
}
