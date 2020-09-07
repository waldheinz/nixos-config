{ config, pkgs, ... }:

{
  networking = {
    useDHCP = false;
    dhcpcd.allowInterfaces = [ "enp1s0" ];
    
    firewall.enable = false;
    interfaces = {
      "enp1s0".useDHCP = true;
      "eno2".useDHCP = false;
      "tap-mdi" = {
        virtual = true;
        virtualOwner = "trem";
        virtualType = "tap";
        useDHCP = false;
      };
      "br-mdi".useDHCP = false;
    };

    bridges."br-mdi".interfaces = [ "eno2" "tap-mdi" ];
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
