{ config, pkgs, ... }:
let
  bb = what: {
    device = "blackbox:" + what;
    fsType = "nfs";
    options = [ "proto=tcp6" ];
  };
in {
  fileSystems = {
    "/mnt/bb/incoming" = bb "/mnt/tank/incoming";
    "/mnt/bb/media" = bb "/mnt/tank/media";
    "/mnt/bb/home-trem" = bb "/home/trem";
  };
}
