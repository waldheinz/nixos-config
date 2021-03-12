{ config, pkgs, ... }:

{
  networking = {
    firewall.enable = false;
    useDHCP = false;
    useNetworkd = true;
  };

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
