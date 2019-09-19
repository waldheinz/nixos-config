{ config, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/i18n.nix
        ../../modules/networking.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/sysctl.nix
        ../../modules/users.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.supportedFilesystems = [ "zfs" ];

    networking.hostName = "blackbox"; # Define your hostname.
    networking.hostId = "bf579583";

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "19.09"; # Did you read the comment?
}
