{ ... }:

{
  networking.hosts = {
    "fd17:e59:91e6:0:ece5:11ff:fe66:a953" = [ "blackbox.lan.waldheinz.de" ];
  };

  fileSystems."/mnt/bb/media" = {
    device = "blackbox.lan.waldheinz.de:/mnt/tank/media";
    fsType = "nfs";
    options = [
      "noauto"
      "rsize=65536" "wsize=65536"
      "soft"
      "x-systemd.automount"
      "x-systemd.idle-timeout=1min"
      "x-systemd.mount-timeout=10"
    ];
  };
}