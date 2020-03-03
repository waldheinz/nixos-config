{ config, pkgs, ... }:

{
  security.acme = {
    email = "mt@waldheinz.de";
    acceptTerms = true;
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."waldnet.chickenkiller.com" = {
      addSSL = true;
      enableACME = true;
      root = "/var/www/waldnet";
      locations = {
        "/" = {
          proxyPass = "http://localhost:8123/";
          extraConfig = ''
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection $connection_upgrade;
          '';
        };
      };
    };
  };
}
