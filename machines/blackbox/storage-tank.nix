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

  fileSystems."/home/trem/tank" =
    { device = "tank/trem";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/time-machine" =
    { device = "tank/time_machine";
      fsType = "zfs";
    };

  fileSystems."/mnt/tank/kodi-wohnzimmer" =
    { device = "tank/kodi-wohnzimmer";
      fsType = "zfs";
    };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt/tank/incoming *(rw,no_subtree_check)
    /mnt/tank/media *(rw,no_subtree_check)
    /mnt/tank/kodi-wohnzimmer *(rw,no_root_squash,no_subtree_check)
    /home/trem *(rw,no_subtree_check)
  '';

}
