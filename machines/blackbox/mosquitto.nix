{ config, pkgs, ... }:

{
  services.mosquitto = {
    enable = true;
    allowAnonymous = true;
    host = "0.0.0.0";
    users = {};
    extraConf = ''
      persistent_client_expiration 2m
      set_tcp_nodelay true
    '';
  };
}
