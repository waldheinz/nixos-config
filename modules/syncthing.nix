{ config, pkgs, ... }:

{ services.syncthing = {
    enable = true;
    user = "trem";
    dataDir = "/home/trem";
    openDefaultPorts = true;
  };
}
