{ config, pkgs, ... }:

{
  services.netatalk = {
    enable = true;
    volumes = {
      Backup = {
        path = "/mnt/tank/time-machine";
        "valid users" = "trem";
        "time machine" = "yes";
      };
      Media = {
        path = "/mnt/tank/media/";
        "valid users" = "trem";
      };
    };
  };
}
