{ }:

{
  frontend = { };

  homekit = {
    filter = { include_domains = [
      "automation"
      "binary_sensor"
      "light"
      "sensor"
      "switch"
      "scene"
    ]; };
  };

  http = {
    use_x_forwarded_for = true;
    trusted_proxies = [ "127.0.0.1" "::1" ];
  };

  logger = {
    default = "info";
    logs = { };
  };

  mqtt = {
    broker = "blackbox.lan.waldheinz.de";
  };

  prometheus = { };
  scene = "!include scenes.yaml";
  tasmota = { };
  zha = { };
}