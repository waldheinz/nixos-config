{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.wireguard ];

  networking.wireguard.interfaces.wg0 = {
    ips = [ "fd17:e59:91e6:d452::100/64" ];
    privateKeyFile = "/etc/nixos/wg-private.key";
    postSetup = ''
      printf "nameserver fd17:e59:91e6:ed98::1" | ${pkgs.openresolv}/bin/resolvconf -a wg0 -m 0
    '';
    postShutdown = "${pkgs.openresolv}/bin/resolvconf -d wg0";
    peers = [
      {
        publicKey = "ExDEgiuxlWpEbVoOTygIH6FcxseSrdY1E0uWMTyWa0A=";
        allowedIPs = [ "fd17:e59:91e6::/48" ];
        endpoint = "waldnet.chickenkiller.com:51348";
        persistentKeepalive = 25;
      }
    ];
  };
}
