{ ... }:

let
  nfsOpts = [
    "rsize=65536" "wsize=65536"
    "soft"
    "user"
    "fsc"
    "noatime"
    "nodiratime"
    "x-systemd.automount"
    "x-systemd.idle-timeout=1min"
    "x-systemd.mount-timeout=10"
  ];
in {

  services.cachefilesd.enable = true;

  fileSystems."/mnt/storinator/incoming" = {
    device = "storinator.lan.waldheinz.de:/volume1/incoming";
    fsType = "nfs";
    options = nfsOpts;
  };

  fileSystems."/mnt/storinator/media" = {
    device = "storinator.lan.waldheinz.de:/volume1/media";
    fsType = "nfs";
    options = nfsOpts;
  };
}
