{ config, pkgs, ... }:

let
    homebridge = import ./homebridge { inherit pkgs; };
    dataDir = "/var/lib/homebridge";
    config = pkgs.writeText "homebridge-config.json" (builtins.toJSON (import ./homebridge-config.nix));
in {
    environment.systemPackages = [ homebridge ];

    systemd.services.homebridge = {
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        description = "homebridge";
        preStart = ''
            ln -sf ${config} "${dataDir}/config.json"
            ln -sf ${./homebridge-config-homematic.json} "${dataDir}/homematic_config.json"
        '';
        serviceConfig = {
            ExecStart = "${homebridge}/bin/homebridge -U ${dataDir}";
            KillSignal = "SIGINT";
            WorkingDirectory = dataDir;
            Restart = "on-failure";
            User = "homebridge";
        };
    };

    users.users.homebridge = {
        description = "Homebridge service user";
        home = dataDir;
        createHome = true;
    };
}
