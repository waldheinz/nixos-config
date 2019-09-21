{ config, pkgs, ... }:

{
  networking = {
    firewall.enable = false;
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
