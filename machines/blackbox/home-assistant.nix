{ config, pkgs, ... }:

{
  services.home-assistant = {
    enable = true;

    package = pkgs.home-assistant.override {
      extraPackages = ps: with ps; [
        aiounifi
        colorlog
        PyChromecast
        zeroconf
      ];
    };

    lovelaceConfig = {
      title = "My Awesome Home";
      views = [
        {
          title = "Übersicht";
          path = "default_view";
          cards = [
            { type = "entities"; title = "Szenen"; show_header_toggle = false; entities = [
              "scene.morgens"
              "scene.nachts"
              ]; }
            { type = "entities"; title = "Heizung"; show_header_toggle = false; entities = [
              "climate.neq1641889"
              "climate.neq1641890"
              "climate.neq1641958"
              "climate.neq1641914"
              "climate.neq1641986"
              "climate.neq1641989"
              "climate.neq1641994"
              ]; }
            { type = "entities"; title = "Licht oben"; entities = [
              "light.licht_flur_oben"
              "light.licht_schreibtisch"
              "light.wohnzimmer_sofa"
              ]; }
            { type = "entities"; title = "Licht unten"; entities = [
              "light.flur_hinten"
              "light.flur_vorn"
              "light.licht_kuche_unter_schrank"
              "light.licht_spiegelschrank"
              "light.licht_treppe"
              "light.nosch_regal"
              "light.schlafzimmer_fussboden"
              ]; }
            { type = "entities"; title = "Wunderbare Menschen"; show_header_toggle = false; entities = [
              "person.janosch"
              "person.matthias"
              ]; }
          ];
        } {
          title = "Einstellungen";
          cards = [
            {
              type = "entities"; title = "Automatisierungen"; secondary_info = "last_triggered"; entities = [
                "automation.jemand_zu_hause"
                "automation.keiner_zu_hause"
                "automation.nosch_kommt"
                "automation.nosch_geht"
              ];
            }
          ];
        }
      ];
    };

    config = {

      logger = {
        default = "info";
        logs = {
          "pyhomematic.devicetypes.generic" = "warning";
        };
      };

      light = [ {
        platform = "group";
        name = "Orientierung";
        entities = [
          "light.flur_hinten"
          "light.licht_flur_oben"
          "light.flur_vorn"
          "light.licht_kuche_unter_schrank"
          "light.licht_spiegelschrank"
          "light.licht_treppe"
        ];
      } ];

      scene = [
        {
          name = "Morgens";
          entities = {
            "light.orientierung" = {
              state = "on";
              rgb_color = [ 60 40 40 ];
              white_value = 30;
              brightness_pct = 50;
              transition = 30;
            };
          };
        } {
          name = "Nachts";
          entities = {
            "light.orientierung" = {
              state = "on";
              rgb_color = [ 100 0 0 ];
              brightness_pct = 40;
              transition = 30;
            };
          };
        }
      ];

      script = {
        heat_on = {
          sequence = [ {
            service = "climate.set_hvac_mode";
            data = { entity_id = "group.climate"; hvac_mode = "auto"; };
          } {
            service = "climate.set_preset_mode";
            data = { entity_id = "group.climate"; preset_mode = "comfort"; };
          } ];
        };

        heat_off = {
          sequence = [ {
            service = "climate.set_preset_mode";
            data = { entity_id = "all"; preset_mode = "eco"; };
          } {
            service = "climate.set_hvac_mode";
            data = { entity_id = "all"; hvac_mode = "heat"; };
          } ];
        };
      };

      automation = [ {
        alias = "Jemand zu Hause";
        trigger = { platform = "state"; entity_id = "group.persons"; to = "home"; };
        action = [ { service = "script.heat_on"; } ];
      } {
        alias = "Keiner zu Hause";
        trigger = { platform = "state"; entity_id = "group.persons"; to = "not_home"; };
        action = [
          { service = "script.heat_off"; }
          { service = "light.turn_off"; entity_id = "group.all_lights"; }
        ];
      } {
        alias = "Nosch kommt";
        trigger = { platform = "state"; entity_id = "person.janosch"; to = "home"; };
        action = [ {
            service = "climate.set_hvac_mode";
            data = { entity_id = "climate.neq1641958"; hvac_mode = "auto"; };
          } {
            service = "climate.set_preset_mode";
            data = { entity_id = "climate.neq1641958"; preset_mode = "comfort"; };
          } ];
      } {
        alias = "Nosch geht";
        trigger = { platform = "state"; entity_id = "person.janosch"; to = "not_home"; };
        action = [ {
            service = "climate.set_preset_mode";
            data = { entity_id = "climate.neq1641958"; preset_mode = "eco"; };
          } {
            service = "climate.set_hvac_mode";
            data = { entity_id = "climate.neq1641958"; hvac_mode = "heat"; };
          } ];
      } ];

      group = {
        persons = { entities = [ "person.janosch" "person.matthias" ]; };

        climate = { entities = [
          "climate.neq1641889"
          "climate.neq1641890"
          "climate.neq1641914"
          "climate.neq1641986"
          "climate.neq1641989"
          "climate.neq1641994"
        ]; };

        auto_lights = { entities = [
          "light.flur_hinten"
          "light.licht_flur_oben"
          "light.flur_vorn"
          "light.licht_kuche_unter_schrank"
          "light.licht_spiegelschrank"
          "light.licht_treppe"
        ]; };
      };

      homekit = {
        include_domains = [ "light" ];
      };

      device_sun_light_trigger = {
        light_group = "group.auto_lights";
        device_group = "group.all_devices";
      };

      homeassistant = {
        name = "zu Hause";
        latitude = 50.821807861328125;
	      longitude = 12.941727797113735;
      };

      mqtt = {
        broker = "blackbox.lan.waldheinz.de";
        discovery = true;
        discovery_prefix = "homeassistant";
      };

      homematic = {
        interfaces.wireless = {
          host = "ccu.lan.waldheinz.de";
        };
      };

      default_config = { };
      frontend = { };
      http = {
        base_url = "https://waldnet.chickenkiller.com/";
        use_x_forwarded_for = true;
        trusted_proxies = "127.0.0.1";
      };
      config = { };
    };
  };
}
