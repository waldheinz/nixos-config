{ config, pkgs, ... }:

{
    services.samba = {
        enable = true;
        syncPasswordsByPam = true;
        shares = {
            Media = {
                browseable = "yes";
                path = "/mnt/tank/media";
                "read only" = false;
                "guest ok" = true;
            };

            incoming = {
                browseable = "yes";
                path = "/mnt/tank/incoming";
                "read only" = false;
            };
        };
    };
}
