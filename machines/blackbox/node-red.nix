{ pkgs, ... }:
let
    # node-red from current 19.03 does not build because of some gyp fuckup, so use this one
    pkgsx = import (builtins.fetchTarball {
        name = "nix-2019-08-23";
        url = https://github.com/nixos/nixpkgs/archive/3226294abe21dc3d720e032467fdd2285ad4dbec.tar.gz;
        sha256 = "1x05g64jb9xgdn9bxyj17fx8iby90bjjnkalfhvr5nhk5mxcx2wr";
    }) {};

    node-red = pkgsx.nodePackages.node-red.override (oldAttrs: {
        buildInputs = oldAttrs.buildInputs ++ [ pkgsx.nodePackages.node-pre-gyp ];
    });

    cfg = {
        dataDir = "/var/lib/node-red";
    };

in {
    systemd.services.node-red = {
        wantedBy = [ "multi-user.target" ]; 
        after = [ "network.target" ];
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
