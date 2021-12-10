{ config, pkgs, ... }:

{
  services.syncthing = rec {
    configDir = "${config.services.syncthing.dataDir}/.config";
    enable = true;
    group = "torrents";
    openDefaultPorts = true;
  };
}
