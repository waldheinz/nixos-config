{ lib, config, pkgs, ... }:

{
  services.prometheus.exporters.node = {
      disabledCollectors = [ "rapl" ];
      enable = true;
      enabledCollectors = [ "systemd" ];
  };

  environment.etc."systemd/dnssd/node-exporter.dnssd".text = ''
      [Service]
      Name=node-exporter on %H
      Type=_prometheus-http._tcp
      Port=${toString config.services.prometheus.exporters.node.port}
  '';
}
