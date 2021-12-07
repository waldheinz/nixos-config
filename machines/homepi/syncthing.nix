{ config, pkgs, ... }:

{
  services.syncthing = rec {
    configDir = "${dataDir}/.config";
    dataDir = "/mnt/intenso/var/syncthing";
    enable = true;
    openDefaultPorts = true;
  };
}
