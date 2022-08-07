{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/basics.nix
    ../../modules/i18n.nix
    ../../modules/syslog-receiver.nix
    ../../modules/users.nix
    ../../modules/zfs.nix
    ../../modules/zsh.nix
    ../../modules/home-assistant
    ./backup.nix
    ./grafana.nix
    ./mosquitto.nix
    ./network.nix
    ./nfs-server.nix
    ./nginx.nix
    ./prometheus
    ./smb.nix
    ./syncthing.nix
    ./transmission.nix
    ./unifi.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "5a882096";

  fileSystems = {
    "/" = { fsType = "ext4"; device = "/dev/disk/by-label/NIXOS_SD"; };
    "/mnt/incoming" = { fsType = "zfs"; device = "homepi/incoming"; };
    "/mnt/media" = { fsType = "zfs"; device = "homepi/media"; };
    "/mnt/time-machine" = { fsType = "zfs"; device = "homepi/time-machine"; };
    "/var/lib/hass" = { fsType = "zfs"; device = "homepi/hass"; };
    "/var/lib/prometheus2" = { fsType = "zfs"; device = "homepi/prometheus"; };
    "/var/lib/syncthing" = { fsType = "zfs"; device = "homepi/syncthing"; };
    "/var/lib/unifi/data" = { fsType = "zfs"; device = "homepi/unifi-data"; };
  };

  networking.hostName = "homepi";
  system.stateVersion = "22.05";
}
