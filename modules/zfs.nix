{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;
  services.zfs.autoSnapshot = {
    enable = true;
    frequent = 8; # keep the latest eight 15-minute snapshots (instead of four)
    monthly = 6;  # keep only six monthly snapshot (instead of twelve)
  };
}
