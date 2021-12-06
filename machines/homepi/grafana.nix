{ config, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    domain = "homepi.lan.waldheinz.de";
    rootUrl = "%(protocol)s://%(domain)s:%(http_port)s/grafana/";

    auth.anonymous = {
      enable = true;
      org_name = "Home";
    };

    provision = {
      enable = true;

      datasources = [
        {
          name = "default";
          type = "prometheus";
          url = "http://homepi.lan.waldheinz.de/prometheus";
          access = "direct";
          isDefault = true;
        }
      ];
    };
  };
}
