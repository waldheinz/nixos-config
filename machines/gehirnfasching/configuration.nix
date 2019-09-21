{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/desktop.nix
        ../../modules/fonts.nix
        ../../modules/i18n.nix
        ../../modules/networking.nix
        ../../modules/nfs-blackbox.nix
        ../../modules/razer.nix
        ../../modules/sway.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/sysctl.nix
        ../../modules/users.nix
        ../../modules/x11.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "gehirnfasching"; # Define your hostname.
    networking.hostId = "e45f2a2c";

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

    system.stateVersion = "19.03";
}
