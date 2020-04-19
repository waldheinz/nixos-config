{ config, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];

  services.zfs = {
    # Since the automatic TRIM will skip ranges it considers too small
    # there is value in occasionally running a full `zpool trim`.
    trim.enable = true;

    autoScrub = {
      enable = true;
      interval = "monthly";
    };

    autoSnapshot = {
      enable = true;
      flags = "-k -p -u";
      monthly = 6;
    };
  };
}
