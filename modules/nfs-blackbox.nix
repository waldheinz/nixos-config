{ config, pkgs, ... }:
let
  bb = what: {
    device = ("blackbox:/mnt/tank/" + what);
    fsType = "nfs";
    options = [ "proto=tcp6" ];
  };
in {
  fileSystems = {
    "/mnt/bb/pr0n" = bb "private/pr0n";
    "/mnt/bb/incoming" = bb "incoming";
    "/mnt/bb/filme" = bb "media/Filme";
    "/mnt/bb/serien" = bb "media/Serien";
    "/mnt/bb/musik" = bb "media/Musik";
    "/mnt/bb/fotos" = bb "private/Fotos";
  };
}
