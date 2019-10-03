{ config, pkgs, ... }:

{
  services.mosquitto = {
    enable = true;
    allowAnonymous = true;
    host = "0.0.0.0";
    users = { DVES_USER = { acl = [ "topic readwrite #" ]; }; };
    extraConf = ''
      persistent_client_expiration 2m
      set_tcp_nodelay true
    '';

    aclExtraConf = ''
      topic readwrite #
    '';
  };
}
