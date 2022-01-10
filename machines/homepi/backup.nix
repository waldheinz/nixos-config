{ lib, ... }:

{
  services.zfs.autoReplication = {
    enable = true;
    host = "blackbox.lan.waldheinz.de";
    username = "homepi-backup";
    localFilesystem = "homepi";
    remoteFilesystem = "tank/homepi-backup";
    identityFilePath = "/etc/nixos/zfs-replicate-key";
  };

  systemd.services.zfs-replication = {
    after = lib.mkForce [ "zfs-snapshot-weekly.service" ];
    wantedBy = lib.mkForce [ "zfs-snapshot-weekly.service" ];
  };
}
