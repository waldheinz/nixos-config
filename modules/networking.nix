{ config, pkgs, ... }:

{
  networking = {
    firewall.enable = false;
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.enable = true;
    ipv6 = true;
  };
}
