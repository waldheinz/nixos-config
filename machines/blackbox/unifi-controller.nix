{ config, pkgs, ... }:

{

  services.unifi = {
    enable = true;
  };

  services.prometheus.exporters.unifi = {
    enable = true;
    unifiAddress = "https://localhost:8443/";
    unifiInsecure = true;
    unifiUsername = "read-only";
    unifiPassword = "pass";
  };
}
