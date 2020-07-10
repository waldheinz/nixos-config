# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../../modules/basics.nix
      ../../modules/i18n.nix
      ../../modules/networking.nix
      ../../modules/sysadmin.nix      
      ../../modules/users.nix
      ../../modules/zsh.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "decoder-trem"; # Define your hostname.
  system.stateVersion = "20.03"; # Did you read the comment?
}

