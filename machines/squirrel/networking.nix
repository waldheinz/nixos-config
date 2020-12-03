{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.allowInterfaces = [ "enp5s0" ];
    
    firewall.enable = false;
    interfaces = {
      "enp5s0".useDHCP = true;
    };
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    ipv6 = true;

    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };
}
