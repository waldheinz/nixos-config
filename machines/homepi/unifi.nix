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

  systemd.services.unifi-available = {
    description = "Wait for Unifi to be available";

    after = [ "unifi.service" ];
    before = [ "prometheus-unifi-exporter.service" ];
    wantedBy = [ "prometheus-unifi-exporter.service" ];

    serviceConfig = {
      ExecStart = "${pkgs.curl}/bin/curl --insecure 'https://localhost:8443/'";
      Restart = "on-failure";
      RestartSec = "10";
      Type = "oneshot";
    };
  };

}
