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
        ];
      }

      {
        job_name = "homematic";
        metrics_path = "/addons/webmatic/cgi/prometheus.cgi";
        static_configs = [ { targets = [ "ccu.lan.waldheinz.de:80" ]; } ];
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
