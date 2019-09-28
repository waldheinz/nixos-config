{ config, pkgs, ... }:
let
  bb = what: {
    device = "blackbox:/mnt/tank/" + what;
    fsType = "nfs";
    options = [ "proto=tcp6" ];
  };
in {
  fileSystems = {
    "/mnt/bb/incoming" = bb "incoming";
    "/mnt/bb/media" = bb "media";
  };
}
