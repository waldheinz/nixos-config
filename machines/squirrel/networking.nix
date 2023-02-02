{ config, pkgs, ... }:

{
  networking = {
    firewall.enable = false;
    useDHCP = false;
    useNetworkd = true;

    wireguard = {
      enable = true;
      interfaces.wg_wld = {
        ips = [ "fd17:0e59:91e6:1::3/64" ];
        privateKeyFile = "/etc/waldnet-priv.key";
        peers = [ {
          allowedIPs = [ "fd17:0e59:91e6::/48" ];
          endpoint = "waldnet.chickenkiller.com:53914";
          persistentKeepalive = 25;
          publicKey = "CDRtNHufsnS1nHt+wxILtmsYusZKokLgvjnyQuxj0zE=";
        } ];
      };
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
