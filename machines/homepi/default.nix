{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/basics.nix
    ../../modules/i18n.nix
    ../../modules/users.nix
    ../../modules/zsh.nix
    ./grafana.nix
    ./nginx.nix
    ./prometheus
    ./unifi.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };

    "/mnt/intenso" = {
      device = "/dev/disk/by-uuid/0c119dab-75bf-4eac-bb6c-53338d5a7f91";
      fsType = "ext4";
    };

    "/var/lib/prometheus2" = {
      device = "/mnt/intenso/var/prometheus";
      fsType = "none";
      options = [ "bind" ];
    };
  };

  networking.hostName = "homepi";
}
