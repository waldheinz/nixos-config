{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    extraFlags = [ "--storage.tsdb.retention.time 10y" ];

    globalConfig = {
      scrape_interval = "30s";
    };

    scrapeConfigs = [
      {
        job_name = "homematic";
        scrape_interval = "60s";
        metrics_path = "/addons/webmatic/cgi/prometheus.cgi";
        static_configs = [
          {
            targets = [ "ccu.lan.waldheinz.de:80" ];
          }
        ];
      }

      {
        job_name = "node";
        static_configs = [
          {
            targets = [ "blackbox.lan.waldheinz.de:9100" ];
          }
        ];
      }

      {
        job_name = "router";
        static_configs = [
          {
            targets = [ "klaus.lan.waldheinz.de:9100" ];
          }
        ];
      }
    ];

  };
}
