{ pkgs, ... }:

let
	ha-no-test = pkgs.home-assistant.overrideAttrs (oldAttrs: {
    doInstallCheck = false;
  });

	ha-with-extra = ha-no-test.override {
      extraPackages = ps: with ps; [
				aiounifi
        colorlog
        PyChromecast
        zeroconf
      ];
    };

in {
	systemd.services.home-assistant.path = [ pkgs.ffmpeg ];

	services.home-assistant = {
		enable = true;
		package = ha-with-extra;

		config = {
			logger = {
        default = "info";
        logs = {
          "homeassistant.components.homekit" = "debug";
        };
      };

			frontend = { };

      homekit = {
        filter = { include_domains = [ "binary_sensor" ]; };
      };

			http = {
        use_x_forwarded_for = true;
        trusted_proxies = "127.0.0.1";
      };

			zha = { };
		};
	};
}
