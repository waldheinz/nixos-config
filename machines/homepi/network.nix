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
      matchConfig = { Name = "e*"; };
      networkConfig = { DHCP = "yes"; MulticastDNS = true; };
    };
  };
}
