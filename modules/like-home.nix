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
  };

  services.cachefilesd.enable = true;

  fileSystems."/mnt/homepi/media" = {
    device = "homepi.lan.waldheinz.de:/mnt/media";
    fsType = "nfs";
    options = nfsOpts;
  };

  fileSystems."/mnt/homepi/incoming" = {
    device = "homepi.lan.waldheinz.de:/mnt/incoming";
    fsType = "nfs";
    options = nfsOpts;
  };
}
