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

  environment.systemPackages = with pkgs; [ hdparm smartmontools ];

  systemd.services.prometheus-node-exporter-smart = {
    description = "Provide SMART data to Prometheus node exporter";

    serviceConfig = {
      ExecStart = pkgs.writeShellScript "update-prometheus-node-smart" ''
        set -euo pipefail

        ${pkgs.node-exporter-textfile-collector-scripts}/bin/smartmon.sh \
          | ${pkgs.moreutils}/bin/sponge ${config.local.node-exporter-textfiles}/smartmon.prom
      '';
    };
  };

  systemd.timers.prometheus-node-exporter-smart = {
    wantedBy = [ "prometheus-node-exporter.service" ];
    timerConfig = {
      OnBootSec = "1min";
      OnUnitActiveSec = "1h10m";
    };
  };

}
