{ config, pkgs, ... }:

let
  textfiles-dir = config.local.node-exporter-textfiles;
in {

  options.local.node-exporter-textfiles = with pkgs.lib; mkOption {
    type = types.str;
    default = "/run/node-exporter-textfiles";
    description = "Where node-exporter finds extra textfiles.";
  };

  config = {
    systemd.tmpfiles.rules = [ "d ${textfiles-dir} 1777 root root" ];

    services.prometheus.exporters.node = {
      enable = true;
      extraFlags = [
          "--collector.textfile.directory ${textfiles-dir}"
          "--collector.systemd.unit-exclude \".*\""  # we need no detailed per-unit metrics, nothing interesting there
          "--web.disable-exporter-metrics"
        ];
    };
  };
}
