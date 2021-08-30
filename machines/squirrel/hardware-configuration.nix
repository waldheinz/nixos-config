# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/04ab4215-dcd7-4bae-b532-b58a7b5efd94";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F38A-32CD";
      fsType = "vfat";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/9e3e10f9-2eb1-44a1-b28d-8793771e1135";
      fsType = "ext4";
    };

  swapDevices = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware = {
    cpu.amd.updateMicrocode = true;
    video.hidpi.enable = lib.mkDefault true;  # high-resolution display
  };
}
