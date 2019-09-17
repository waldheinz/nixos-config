{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/fonts.nix
        ../../modules/i18n.nix
        ../../modules/networking.nix
        ../../modules/nfs-blackbox.nix
        ../../modules/sway.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/sysctl.nix
        ../../modules/users.nix
        ../../modules/x11.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
    ];

    nixpkgs.config.allowUnfree = true;

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = [ "zfs" ];

    networking.hostName = "gehirnfasching"; # Define your hostname.
    networking.hostId = "e45f2a2c";

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
