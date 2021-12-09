{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "gfpool/root/nixos";
      fsType = "zfs";
    };

  fileSystems."/home" =
    { device = "gfpool/home";
      fsType = "zfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6109-84A3";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 16;
}
