{ config, pkgs, ... }:

{
    services.samba = {
        enable = true;
        package = pkgs.sambaFull;
        syncPasswordsByPam = true;

        extraConfig = ''
            mdns name = mdns
            min protocol = SMB2
            vfs objects = catia fruit streams_xattr
            map to guest = bad user
            fruit:metadata = stream
            fruit:model = MacSamba
            fruit:posix_rename = yes
            fruit:veto_appledouble = no
            fruit:wipe_intentionally_left_blank_rfork = yes
            fruit:delete_empty_adfiles = yes
        '';

        shares = {
            Media = {
                browseable = "yes";
                path = "/mnt/tank/media";
                "read only" = false;
                "guest ok" = true;
            };

            Public = {
                browseable = "yes";
                path = "/mnt/tank/public";
                "read only" = false;
                "guest ok" = true;
            };

            incoming = {
                browseable = "yes";
                path = "/mnt/tank/incoming";
                "read only" = false;
            };

            trem = {
                browseable = "yes";
                path = "/home/trem";
                "valid users" = "trem";
                public = "no";
                writeable = "yes";
            };

            "Time Machine" = {
                browseable = "yes";
                path = "/mnt/tank/time-machine";
                "valid users" = "trem";
                public = "no";
                writeable = "yes";
                "force user" = "trem";
                "fruit:time machine" = "yes";
                "vfs objects" = "catia fruit streams_xattr";
            };
        };
    };
}
