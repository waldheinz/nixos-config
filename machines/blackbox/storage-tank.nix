{ config, pkgs, lib, ... }:

let
  devices = [
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4E3TV59KV"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4E4ZANL7A"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4E6FT69XL"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4E7JZVX8D"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4EFHCFD5Y"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4EHCEAP1H"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4EKDH4SJ6"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4EKTN9PKV"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4ENNRS9V3"
    "ata-WDC_WD40EFRX-68WT0N0_WD-WCC4EPA9U4C6"
  ];
in {

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

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /mnt/tank/incoming *(rw,no_subtree_check)
    /mnt/tank/media *(rw,no_subtree_check)
    /mnt/tank/public *(rw,no_subtree_check)
    /home/trem *(rw,no_subtree_check)
  '';

  boot.kernelParams = [ "zfs.l2arc_noprefetch=0" ];

  environment.systemPackages = with pkgs; [ hdparm smartmontools ];

  systemd = {
    services.zpool-tank-hdparm = {
      description = "Tune hdparm for zfs pool tank";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = pkgs.writeShellScript "zpool-tank-hdparm" ''
          set -euo pipefail

          ${lib.concatMapStrings (d: pkgs.hdparm + "/bin/hdparm -S 244 /dev/disk/by-id/" + d + "\n") devices}
        '';

        Type = "oneshot";
      };
    };

    services.prometheus-node-exporter-smart = {
      description = "Provide SMART data to Prometheus node exporter";

      serviceConfig = {
        ExecStart = pkgs.writeShellScript "update-prometheus-node-smart" ''
          set -euo pipefail

          ${pkgs.node-exporter-textfile-collector-scripts}/bin/smartmon.sh \
            | ${pkgs.moreutils}/bin/sponge ${config.local.node-exporter-textfiles}/smartmon.prom
        '';
      };
    };

    timers.prometheus-node-exporter-smart = {
      wantedBy = [ "prometheus-node-exporter.service" ];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "2h10m";
      };
    };
  };
}
