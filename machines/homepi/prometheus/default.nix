{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;

    extraFlags = [
      "--storage.tsdb.retention.time 10y"
      "--web.external-url http://localhost:9090/prometheus/"
    ];

    globalConfig = {
      scrape_interval = "1m";
      scrape_timeout = "30s";
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          { targets = [ "localhost:9100" ]; labels = { instance = "${config.networking.hostName}"; }; }
          { targets = [ "blackbox.lan.waldheinz.de:9100" ]; labels = { instance = "blackbox"; }; }
        ];
      }

      {
        job_name = "hass";
        metrics_path = "/api/prometheus";
        bearer_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzOGNhM2NlNGYyNWQ0ZjYyYTQwOWEwMTFlZWY3MGVmOCIsImlhdCI6MTYzOTI1MzgyMCwiZXhwIjoxOTU0NjEzODIwfQ.w0BV2kT-Ar2H1QuisO8KM8XPYIwZxos5hYBAhQs2xQ8";
        static_configs = [ { targets = [ "localhost:8123" ]; } ];
      }

      {
        job_name = "router";
        static_configs = [ { targets = [ "klaus.lan.waldheinz.de:9100" ]; } ];
      }

      {
        job_name = "unifi";
        static_configs = [ { targets = [ "localhost:9130" ]; } ];
      }

    ];
  };

  services.prometheus.exporters.node = {
    disabledCollectors = [ "rapl" ];
    enabledCollectors = [ "systemd" ];
    enable = true;
  };
}
