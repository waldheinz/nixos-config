{ configDir }:

let
  thermostats = [
    { suffix = "bathroom"; ieee = "84:fd:27:ff:fe:d5:a1:ab"; }
    { suffix = "bedroom"; ieee = "84:fd:27:ff:fe:d4:33:5f"; }
    { suffix = "child_room"; ieee = "84:fd:27:ff:fe:d4:33:57"; }
    { suffix = "kitchen"; ieee = "84:fd:27:ff:fe:d4:31:e0"; }
    { suffix = "living_room_1"; ieee = "84:fd:27:ff:fe:d4:31:d9"; }
    { suffix = "living_room_2"; ieee = "84:fd:27:ff:fe:d4:31:7b"; }
    { suffix = "workroom"; ieee = "84:fd:27:ff:fe:d4:1b:74"; }
  ];
in {
  # SetOption105 1
  # RGBWWTable 255,255,255,255,255
  # RGBWWTable 255,255,255,190,0
  # Restart 1

  automation = "!include automations.yaml";

  discovery = { };

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
      "climate"
      "light"
      "sensor"
      "switch"
    ]; };
  };

  http = {
    use_x_forwarded_for = true;
    trusted_proxies = [ "127.0.0.1" "::1" ];
  };

  ios = { };

  logger = {
    default = "info";
    # logs = {
    #   zigpy = "debug";
    #   "homeassistant.components.zha" = "debug";
    #   "zigpy_deconz.zigbee.application" = "debug";
    #   "zigpy_deconz.api" = "debug";
    # };
  };

  mobile_app = { };

  mqtt = {
    broker = "blackbox.lan.waldheinz.de";
  };

  my = { };

  prometheus = { };
  scene = "!include scenes.yaml";

  script =
    let
      go = t: { name = "ext_temp_" + t.suffix; value = {
        mode = "single";

        fields.temp = {
          name = "Temperature";
          selector.number = { min = 0; max = 60; step = 0.1; unit_of_measurement = "°C"; mode = "slider"; };
        };

        sequence = [
          {
            service = "zha.set_zigbee_cluster_attribute";
            data = {
              ieee = t.ieee;
              endpoint_id = 1;
              cluster_id = 513;
              attribute = 16405;
              cluster_type = "in";
              value = "{{ (temp * 100) | int }}";
            };
          }
        ];
      }; };
    in
      builtins.listToAttrs (map go thermostats);

  sensor = [
    {
      platform = "sql";
      db_url = "sqlite:///var/lib/hass/zigbee.db";
      scan_interval = 30;
      queries =
        let
          go = t: {
            name = "heat_demand_${t.suffix}";
            query = "SELECT value FROM attributes_cache_v7 where ieee = '${t.ieee}' and cluster = 513 and attrid = 8";
            column = "value";
            unit_of_measurement = "%";
          };
        in map go thermostats;
    }
  ];

  tasmota = { };

  zha = {
    custom_quirks_path = "${configDir}/custom_zha_quirks/";
    zigpy_config.ota = {
      ikea_provider = true;
      otau_directory = "${configDir}/zigpy_ota/";
    };
  };
}
