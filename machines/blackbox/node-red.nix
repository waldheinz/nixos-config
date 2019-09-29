{ pkgs, ... }:
let
    node-red = pkgs.nodePackages.node-red.override (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ pkgs.nodePackages.node-pre-gyp ];
    });

    cfg = {
        dataDir = "/var/lib/node-red";
    };

in {
    systemd.services.node-red = {
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        description = "node-red";
        serviceConfig = {
            ExecStart = "${node-red}/bin/node-red";
            KillSignal = "SIGINT";
            WorkingDirectory = cfg.dataDir;
            Restart = "on-failure";
            User = "node-red";
        };
    };

    environment.systemPackages = [ node-red ];

    users.users.node-red = {
        description = "Node-RED service user";
        home = cfg.dataDir;
        createHome = true;
    };
}
