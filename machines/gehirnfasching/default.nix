{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ../../modules/basics.nix
        ../../modules/desktop.nix
        ../../modules/direnv.nix
        ../../modules/fonts.nix
        ../../modules/hobby.nix
        ../../modules/i18n.nix
        ../../modules/networking.nix
        ../../modules/razer.nix
        ../../modules/scripts
        ../../modules/sway.nix
        ../../modules/syncthing.nix
        ../../modules/sysadmin.nix
        ../../modules/users.nix
        ../../modules/work.nix
        ../../modules/x11.nix
        ../../modules/zfs.nix
        ../../modules/zsh.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "gehirnfasching"; # Define your hostname.
    networking.hostId = "e45f2a2c";

    system.stateVersion = "19.03";

    fileSystems."/mnt/hp/media" = {
        device = "homepi.lan.waldheinz.de:/mnt/media";
        fsType = "nfs";
    };

    fileSystems."/mnt/hp/incoming" = {
        device = "homepi.lan.waldheinz.de:/mnt/incoming";
        fsType = "nfs";
    };

    fileSystems."/mnt/hp/home/trem" = {
        device = "homepi.lan.waldheinz.de:/home/trem";
        fsType = "nfs";
    };

    fileSystems."/mnt/media" = {
        device = "storinator.lan.waldheinz.de:/volume1/media";
        fsType = "nfs";
    };
}
