{ config, pkgs, ... }:

{
  services.prometheus = {
    enable = true;
    extraFlags = [ "--storage.tsdb.retention.time 10y" ];
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
    ];
  };
}
