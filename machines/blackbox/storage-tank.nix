{ config, pkgs, ... }:

{

  fileSystems."/mnt/tank/incoming" =
    { device = "tank/incoming";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media" =
    { device = "tank/media";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private" =
    { device = "tank/private";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/backups" =
    { device = "tank/private/backups";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/remote" =
    { device = "tank/remote";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/remote/kodi-wohnzimmer" =
    { device = "tank/remote/kodi-wohnzimmer";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/remote/kodi-wohnzimmer/thumbs" =
    { device = "tank/remote/kodi-wohnzimmer/thumbs";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/remote/kodi-wohnzimmer/backup" =
    { device = "tank/remote/kodi-wohnzimmer/backup";
      fsType = "zfs";
    };

  fileSystems."/home/trem/tank" =
    { device = "tank/trem";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/time-machine" =
    { device = "tank/time_machine";
      fsType = "zfs";
    };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt/tank/incoming fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/media fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/remote/kodi-wohnzimmer/backup fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/remote/kodi-wohnzimmer/thumbs fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
  '';

}
