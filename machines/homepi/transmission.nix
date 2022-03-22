{ config, pkgs, ... }:

{
  services.transmission = {
    enable = true;
    group = "torrents";
    openPeerPorts = true;
    settings = {
      download-dir = "/mnt/incoming";
      incomplete-dir-enabled = false;
      peer-port-random-high = 65500;
      peer-port-random-low = 65300;
      peer-port-random-on-start = true;
      rpc-host-whitelist = "homepi.lan.waldheinz.de";
    };
  };
}
