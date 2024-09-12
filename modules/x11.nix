{ config, pkgs, ... }:

{
  services = {
    xserver = {
        enable = true;
        xkb.layout = "de";
        desktopManager = {
            plasma5.enable = true;
        };
    };

    displayManager.sddm = {
      enable = true;
    };
  };
}
