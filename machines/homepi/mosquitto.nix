{ config, pkgs, ... }:

{
  services.mosquitto = {
    enable = true;
    logDest = [ "syslog" ];

    settings = {
      persistent_client_expiration = "2m";
      set_tcp_nodelay = true;
    };

    listeners = [ {
      acl = [ "topic readwrite #" ];
      omitPasswordAuth = true;
      settings = { allow_anonymous = true; };
      users = { DVES_USER = { acl = [ "readwrite #" ]; }; };
    } ];
  };
}
