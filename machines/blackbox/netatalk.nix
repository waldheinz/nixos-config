{ config, pkgs, ... }:

{
  services.netatalk = {
    enable = true;
    volumes = {
      Media = {
        path = "/mnt/tank/media/";
        "valid users" = "trem";
      };
    };
  };
}
