{ config, pkgs, ... }:

{
  systemd.services.transmission = {
    bindsTo = [ "netns-pia.service" ];
    after = [ "netns-pia.service" ];
    serviceConfig = {
      NetworkNamespacePath = "/var/run/netns/pia";
      PrivateNetwork = true;
    };
  };

  environment.systemPackages = [ pkgs.curl pkgs.jq pkgs.transmission ];

  systemd.services.transmission-pia-port = {
    after = [ "transmission.service" "openvpn-pia.service" "netns-pia.service" ];
    bindsTo = [ "transmission.service" "openvpn-pia.service" "netns-pia.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      NetworkNamespacePath = "/var/run/netns/pia";
      PrivateNetwork = true;
      RemainAfterExit = true;
      Type = "oneshot";
      ExecStart = pkgs.writeScript "transmission-pia-port.sh" ''
        #!${pkgs.stdenv.shell}
        set -e

        echo "sleeping to allow pia to connect..."
        sleep 10

        CLIENT_ID=`head -n 100 /dev/urandom | sha256sum | tr -d " -"`
        URL="http://209.222.18.222:2000/?client_id=$CLIENT_ID"
        PORT=$(${pkgs.curl}/bin/curl --silent "$URL" | ${pkgs.jq}/bin/jq -r .port)
        echo "got assignment for port $PORT (client id $CLIENT_ID)"
        ${pkgs.transmission}/bin/transmission-remote -p "$PORT"
      '';
    };
  };

  services.transmission = {
    enable = true;
    group = "torrents";
  };
}
