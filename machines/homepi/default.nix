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
    ./grafana.nix
    ./network.nix
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
    "/mnt/incoming" = { fsType = "zfs"; device = "lacie/incoming"; };
    "/mnt/time-machine" = { fsType = "zfs"; device = "lacie/time-machine"; };
    "/var/lib/hass" = { fsType = "zfs"; device = "lacie/hass"; };
    "/var/lib/prometheus2" = { fsType = "zfs"; device = "lacie/prometheus"; };
    "/var/lib/syncthing" = { fsType = "zfs"; device = "lacie/syncthing"; };
  };

  networking.hostName = "homepi";
}
