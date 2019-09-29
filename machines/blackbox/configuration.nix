{ config, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/i18n.nix
        ../../modules/monitoring.nix
        ../../modules/networking.nix
        ../../modules/pia.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/sysctl.nix
        ../../modules/transmission.nix
        ../../modules/users.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
        ./grafana.nix
        ./minecraft.nix
        ./mosquitto.nix
        ./netatalk.nix
        ./node-red.nix
        ./printing.nix
        ./prometheus.nix
        ./storage-tank.nix
    ];

    # tune syncthing
    services.syncthing = {
      dataDir = "/home/trem/tank/sync";
      guiAddress = "[::]:8384";
    };

    services.transmission.settings = {
      download-dir = "/mnt/tank/incoming/torrents";
      rpc-host-whitelist = "blackbox.lan.waldheinz.de";
      rpc-host-whitelist-enabled = true;
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "blackbox"; # Define your hostname.
    networking.hostId = "bf579583";

    system.stateVersion = "19.09";
}
