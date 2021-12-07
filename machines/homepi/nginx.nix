{ config, pkgs, ... }:

{
  networking.firewall.allowedTCPPorts = [ 80 ];

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    proxyTimeout = "600s";  # recommended for syncthing, but probably good enough for everything

    virtualHosts."${config.networking.hostName}.lan.meetwise.de" = {
      root = builtins.path { path = ./www-root; };

      locations = {
        "/grafana/" = { proxyPass = "http://127.0.0.1:3000/"; proxyWebsockets = true; };
        "/prometheus" = { proxyPass = "http://localhost:9090/prometheus"; };
        "/syncthing/" = { proxyPass = "http://${config.services.syncthing.guiAddress}/"; };
        "/transmission" = {  proxyPass = "http://localhost:${toString config.services.transmission.settings.rpc-port}"; };
      };
    };
  };

}
