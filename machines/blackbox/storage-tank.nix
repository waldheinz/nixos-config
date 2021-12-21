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

  users.users.homepi-backup = {
    description = "Backup Receiver for homepi";
    isSystemUser = true;
    group = "users";
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCR8Fw8ZjILr9M0THmV5ct1WRlDE5Y9a1EjyaQEjka1QeZgN8Gsze6la97fALvGQyuwP1Y1RZFKTpydjj5GBNXtxVI+AdtF5JcpIbag+WKso+X9cuVHapoeKM682zxaJ5wb8rYR8Lj3mo9qkIrf9gycPp16yQx+yXveK4dI/7yyXtzPvIoq9nGuLZJMLMcvBrQ5cMMjDAx/DNFINyKe8jbnMqL997CVP2MhqA2z1yzIHer09B18GBXUkUwdpDmaDj2579jTA0+oEIlW1audJZkVN+P/NGgnfISq2wp2bG0hMXKQrP2XGCaXw7BDI8+WQAG8BdeTK5XOs6zdwMoqEdD43nGgQKoxsXLXVUQuY8joCdPoWMnq1UjL7l7jkf1F5hywl2gC3ARsaCGPMNFKI8egVuoipJBCVSg3G2J4dGF3/vt8hlH/0XvvVj4703E6mEsGTldSkwPOc1dru4T9l3eX8j6nIcmVYbe0MXbZJZojJ/UoYLHNzb4nXr3De86R9E= root@homepi"
    ];
  };

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
