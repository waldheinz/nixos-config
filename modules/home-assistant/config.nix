{ configDir }:

{
  adaptive_lighting = {
    max_brightness = 80;
    min_brightness = 20;
    lights = [
      "light.flur_hinten"
      "light.flur_oben"
      "light.flur_vorn"
      "light.treppe"
    ];
  };

  # SetOption105 1
  # RGBWWTable 255,255,255,255,255
  # RGBWWTable 255,255,255,190,0
  # Restart 1

  automation = "!include automations.yaml";

  frontend = { };

  homeassistant = {
    name = "CvO";
    latitude = 50.82174226798063;
    longitude = 12.941650389750592;
    elevation = 430;
    unit_system = "metric";
    time_zone = "Europe/Berlin";
    internal_url = "http://hass.lan.waldheinz.de";
    legacy_templates = false;
  };

  homekit = {
    filter = { include_domains = [
      "automation"
      "binary_sensor"
      "climate"
      "light"
      "scene"
      "sensor"
      "switch"
    ]; };
  };

  http = {
    use_x_forwarded_for = true;
    trusted_proxies = [ "127.0.0.1" "::1" ];
  };

  logger = {
    default = "info";
  };

  mqtt = {
    broker = "blackbox.lan.waldheinz.de";
  };

  my = { };

  prometheus = { };
  scene = "!include scenes.yaml";
  tasmota = { };

  zha = {
    zigpy_config.ota = {
      ikea_provider = true;
      otau_directory = "${configDir}/zigpy_ota/";
    };
  };
}
