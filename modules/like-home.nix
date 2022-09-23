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
  networking.hosts = {
    "fd17:e59:91e6::1" = [ "klaus.lan.waldheinz.de" ];
    "fd17:e59:91e6:0:e65f:1ff:fe4c:9961" = [ "hass.lan.waldheinz.de" "homepi.lan.waldheinz.de" ];
    "fd17:e59:91e6:0:ece5:11ff:fe66:a953" = [ "blackbox.lan.waldheinz.de" ];
    "fd17:e59:91e6:0:9209:d0ff:fe15:d569" = [ "storinator.lan.waldheinz.de" ];
  };

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
