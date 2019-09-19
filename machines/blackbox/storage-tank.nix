{ config, pkgs, ... }:

{

  fileSystems."/mnt/tank" =
    { device = "tank";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/incoming" =
    { device = "tank/incoming";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media" =
    { device = "tank/media";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media/Dokus" =
    { device = "tank/media/Dokus";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media/Filme" =
    { device = "tank/media/Filme";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media/Musik" =
    { device = "tank/media/Musik";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/media/Serien" =
    { device = "tank/media/Serien";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private" =
    { device = "tank/private";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/Fotos" =
    { device = "tank/private/Fotos";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/backups" =
    { device = "tank/private/backups";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/backups/macbook" =
    { device = "tank/private/backups/macbook";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/pr0n" =
    { device = "tank/private/pr0n";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/private/sync" =
    { device = "tank/private/sync";
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

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt/tank/incoming fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/media/Filme fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/media/Musik fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/media/Serien fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/private/Fotos fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/private/pr0n fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/remote/kodi-wohnzimmer/backup fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
    /mnt/tank/remote/kodi-wohnzimmer/thumbs fd17:0e59:91e6::/48(rw) 192.168.1.0/24(rw)
  '';

}
