{ pkgs, config, ... }:

let
	ha-no-test = pkgs.home-assistant.overrideAttrs (oldAttrs: {
    doInstallCheck = false;
  });

	ha-with-extra = ha-no-test.override {
      extraPackages = ps: with ps; [
				aiounifi
        colorlog
        hatasmota
        PyChromecast
        zeroconf
      ];
    };

  ha-config = import ./config.nix { configDir = config.services.home-assistant.configDir; };

in {
	systemd.services.home-assistant.path = [ pkgs.ffmpeg ];

	services.home-assistant = {
		config = ha-config;
		enable = true;
		package = ha-with-extra;
	};
}
