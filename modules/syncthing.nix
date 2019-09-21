{ config, pkgs, ... }:

{ services.syncthing = {
    enable = true;
    user = "trem";
    openDefaultPorts = true;
    configDir = "/home/trem/.config/syncthing";
  };
}
