{ config, pkgs, ... }:

{
  systemd.services.transmission = {
    bindsTo = [ "netns-pia.service" ];
    after = [ "netns-pia.service" ];
    serviceConfig = {
      NetworkNamespacePath = "/var/run/netns/pia";
      PrivateNetwork = true;
    };
  };

  services.transmission = {
    enable = true;
    group = "torrents";
  };
}
