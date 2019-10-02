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
    ../../modules/sway.nix
    ../../modules/syncthing.nix
    ../../modules/sysadmin.nix
    ../../modules/sysctl.nix
    ../../modules/users.nix
    ../../modules/vpn.nix
    ../../modules/work.nix
    ../../modules/zfs.nix
    ../../modules/zsh.nix
    ./hardware-configuration.nix
    ./nfs-blackbox.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "squirrel"; # Define your hostname.
  networking.hostId = "33f63802";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  system.stateVersion = "19.03";
}
