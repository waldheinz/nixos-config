{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8443 ];

  services.unifi = {
    enable = true;
    openPorts = true;
  };

  services.prometheus.exporters.unifi = {
    enable = true;
    unifiAddress = "https://localhost:8443/";
    unifiInsecure = true;
    unifiUsername = "read-only";
    unifiPassword = "pass";
  };

}
