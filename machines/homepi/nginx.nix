{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    proxyTimeout = "600s";  # recommended for syncthing, but probably good enough for everything

    virtualHosts = {
      "${config.networking.hostName}.lan.waldheinz.de" = {
        root = builtins.path { path = ./www-root; };

        extraConfig = ''
          access_log off;
          error_log stderr;
        '';

        locations = {
          "/grafana/" = { proxyPass = "http://127.0.0.1:3000/"; proxyWebsockets = true; };
          "/prometheus" = { proxyPass = "http://localhost:9090/prometheus"; };
          "/syncthing/" = { proxyPass = "http://${config.services.syncthing.guiAddress}/"; };
          "/transmission" = { proxyPass = "http://127.0.0.1:${toString config.services.transmission.settings.rpc-port}"; };
        };
      };

      "hass.lan.waldheinz.de" = {
        extraConfig = ''
          access_log off;
          error_log stderr;
        '';

        locations."/" = { proxyPass = "http://localhost:8123/"; proxyWebsockets = true; };
      };
    };
  };

}
