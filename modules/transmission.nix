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
    settings = {
      rpc-whitelist = "127.0.0.1,10.0.0.*";
    };
  };
}
