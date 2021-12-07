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

  fileSystems."/mnt/tank/public" =
    { device = "tank/public";
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
    /mnt/tank/incoming *(rw,no_subtree_check)
    /mnt/tank/media *(rw,no_subtree_check)
    /mnt/tank/public *(rw,no_subtree_check)
    /home/trem *(rw,no_subtree_check)
  '';

  boot.kernelParams = [ "zfs.l2arc_noprefetch=0" ];
}
