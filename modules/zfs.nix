{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };

  services.zfs.autoSnapshot = {
    enable = true;
    flags = "-k -p -u";
    monthly = 6;
  };
}
