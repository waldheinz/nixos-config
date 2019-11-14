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

      Fotos = {
        path = "/home/trem/tank/Fotos";
        "valid users" = "trem";
      };

      Incoming = {
        path = "/mnt/tank/incoming";
        "valid users" = "trem";
      };

      Media = {
        path = "/mnt/tank/media/";
        "valid users" = "trem";
      };
    };
  };
}
