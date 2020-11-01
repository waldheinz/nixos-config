let
    h801 = { name, desc }: {
        accessory = "mqttthing";
        type = "lightbulb";
        name = desc;
        url = "mqtt://blackbox.lan.waldheinz.de:1883";
        topics = {
            getRGBW = {
                topic = name + "/tele/STATE";
                apply = "return JSON.parse(message).Color";
            };
            setRGBW = name + "/cmnd/color";
            getOn = {
                topic = name + "/tele/STATE";
                apply = "return JSON.parse(message).POWER";
            };
            setOn = name + "/cmnd/power";
            getOnline = name + "/tele/LWT";
        };
        # logMqtt = true;
        onValue = "ON";
        offValue = "OFF";
        onlineValue = "Online";
        offlineValue = "Offline";
    };
in {
    bridge = {
        "name" = "Homebridge";
        "username" = "CC:22:3D:E3:CE:30";
        "port" = 51826;
        "pin" = "021-53-146";
    };

    platforms = [
        {
            platform = "HomeMatic";
            name = "HomeMatic CCU";
            ccu_ip = "ccu.lan.waldheinz.de";
            subsection = "Homekit";
        }
    ];

    accessories = [
        (h801 { name = "licht-bad-spiegel"; desc = "Spiegel"; })
        (h801 { name = "licht-flur-hinten"; desc = "Unten Hinten"; })
        (h801 { name = "licht-flur-oben"; desc = "Oben"; })
        (h801 { name = "licht-flur-vorn"; desc = "Unten Vorn"; })
        (h801 { name = "licht-k-uschrank"; desc = "Küche Boden"; })
        (h801 { name = "licht-nosch-regal"; desc = "Regal"; })
        (h801 { name = "licht-schreibtisch"; desc = "Schreibtisch"; })
        (h801 { name = "licht-sz-boden"; desc = "Boden"; })
        (h801 { name = "licht-treppe"; desc = "Treppe"; })
        (h801 { name = "licht-wz-sofa"; desc = "Sofa"; })
        (h801 { name = "tasmota_318AF2"; desc = "Deko 1"; })
        (h801 { name = "tasmota_318B66"; desc = "Deko 4"; })
        (h801 { name = "tasmota_318BB5"; desc = "Deko 3"; })
        (h801 { name = "tasmota_318BCC"; desc = "Schrank Wohnzimmer"; })
        (h801 { name = "tasmota_318F90"; desc = "Deko 2"; })
    ];
}
