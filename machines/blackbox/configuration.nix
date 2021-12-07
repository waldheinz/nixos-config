{ config, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/homebridge.nix
        ../../modules/i18n.nix
        ../../modules/monitoring.nix
        ../../modules/networking.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/transmission.nix
        ../../modules/users.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
        ./minecraft.nix
        ./mosquitto.nix
        ./printing.nix
        ./smb.nix
        ./storage-tank.nix
        ./typo3.nix
    ];

    environment.systemPackages = with pkgs; [
      mosquitto
    ];

    networking.bonds.bond0 = {
      interfaces = [ "enp7s0" "enp8s0" ];
      driverOptions = { mode = "802.3ad"; };
    };

    # tune syncthing
    services.syncthing = {
      dataDir = "/home/trem/tank/sync";
      guiAddress = "[::]:8384";
    };

    services.transmission.settings = {
      download-dir = "/mnt/tank/incoming/torrents";
      encryption = 0;
      incomplete-dir-enabled = false;
      port-forwarding-enabled = false;
      rpc-bind-address = "0.0.0.0";
      rpc-host-whitelist = "blackbox.lan.waldheinz.de";
      rpc-host-whitelist-enabled = true;
      rpc-whitelist = "127.0.0.1,192.168.1.*";
      speed-limit-down = 4096;
      speed-limit-down-enabled = true;
      speed-limit-up = 256;
      speed-limit-up-enabled = true;
      trash-original-torrent-files = true;
      watch-dir = "/mnt/tank/incoming/torrentdrop";
      watch-dir-enabled = true;
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "blackbox"; # Define your hostname.
    networking.hostId = "bf579583";

    system.stateVersion = "19.09";
}
