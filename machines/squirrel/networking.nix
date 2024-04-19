{ config, pkgs, ... }:

{
  networking = {
    firewall.enable = false;
    useDHCP = false;
    useNetworkd = true;

    wireguard = {
      enable = false;
      interfaces.wg_wld = {
        ips = [ "192.168.10.3/32" ];
        privateKeyFile = "/etc/waldnet-priv.key";
        peers = [ {
          allowedIPs = [ "192.168.10.0/24" "192.168.1.0/24" ];
          endpoint = "waldnet.chickenkiller.com:51820";
          persistentKeepalive = 30;
          publicKey = "3ISKmcW5yJ3MqF3ZJ5xoYW2wKchN2dKqkC5DFLZRXlE=";
        } ];
      };
    };

    hosts = {
        "192.168.1.12" = [ "storinator.lan.waldheinz.de" ];
    };
  };

  services.resolved.dnssec = "false";

  systemd.network = {
    enable = true;

    networks.ethernet = {
      matchConfig = { Name = "en*"; };
      networkConfig = { DHCP = "yes"; MulticastDNS = true; };
    };
  };

  services.avahi = {
    enable = true;
    ipv6 = true;
    publish.enable = false;
  };
}
