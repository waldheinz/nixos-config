{ config, pkgs, ... }:

{
    environment.systemPackages = [ pkgs.wireguard ];

    networking.wireguard.interfaces.wg0 = {
        ips = [ "10.123.0.2/24" ];
        privateKeyFile = "/etc/nixos/wg-private.key";

        peers = [
            {
                publicKey = "ejYzdObWpLRDr7zXHszrm5QkZFGz8wprj2tkNGM+41U=";
                allowedIPs = [ "10.123.0.0/24" ];
                endpoint = "waldnet.chickenkiller.com:51820";
                persistentKeepalive = 25;
            }
        ];
    };
}
