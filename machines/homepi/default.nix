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
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
    };
  };

  networking.hostName = "homepi";
}
