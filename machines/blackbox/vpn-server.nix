{ config, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.wireguard ];

    networking.wireguard.interfaces.wg0 = {
        ips = [ "10.123.0.1/24" ];
        privateKeyFile = "/etc/nixos/wg-private.key";
        listenPort = 51820;

        peers = [
            {   # squirrel
                publicKey = "ApriVVNsQB8tfofQ1A6KU7uTyXK9zhu8uV2PTWMaVjI=";
                allowedIPs = [ "10.123.0.2/32" ];
            }
        ];
    };
}
