# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/basics.nix
      ../../modules/direnv.nix
      ../../modules/fonts.nix
      ../../modules/i18n.nix
      ../../modules/networking.nix
      ../../modules/sway.nix
      ../../modules/syncthing.nix
      ../../modules/sysadmin.nix
      ../../modules/sysctl.nix
      ../../modules/users.nix
      ../../modules/vpn.nix
      ../../modules/zfs.nix
      ../../modules/zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "squirrel"; # Define your hostname.
  networking.hostId = "33f63802";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
