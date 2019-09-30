{ config, pkgs, ... }:
let
  bb = what: {
    device = "blackbox:/mnt/tank/" + what;
    fsType = "nfs";
    options = [
      "nofail"
      "rsize=16384"
      "wsize=16384"
      "x-systemd.requires=wireguard-wg0-peer-ExDEgiuxlWpEbVoOTygIH6FcxseSrdY1E0uWMTyWa0A\\x3d.service"
    ];
  };
in {
  fileSystems = {
    "/mnt/bb/incoming" = bb "incoming";
    "/mnt/bb/media" = bb "media";
  };
}
