{ config, pkgs, ... }:

{
  imports = [
    ../../modules/basics.nix
    ../../modules/desktop.nix
    ../../modules/direnv.nix
    ../../modules/fonts.nix
    ../../modules/i18n.nix
    ../../modules/networking.nix
    ../../modules/razer.nix
    ../../modules/syncthing.nix
    ../../modules/sysadmin.nix
    ../../modules/users.nix
    ../../modules/work.nix
    ../../modules/x11.nix
    ../../modules/zfs.nix
    ../../modules/zsh.nix
    ./hardware-configuration.nix
  ];

  fileSystems = {
    "/mnt/bambi" = {
      device = "bambi.lan.meetwise.de:/";
      fsType = "nfs";
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "squirrel"; # Define your hostname.
  networking.hostId = "33f63802";

  system.stateVersion = "19.03";
}
