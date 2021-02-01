{ pkgs, lib, config, ... }:
let
  app = "waldnet";
  domain = "${app}.chickenkiller.com";
  dataDir = "/srv/http/${domain}";
  typo-src = pkgs.callPackage ./typo-src.nix { };
in {
  services.phpfpm.pools.${app} = {
    user = app;

    settings = {
      "listen.owner" = config.services.nginx.user;
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 5;
      "php_admin_value[error_log]" = "stderr";
      "php_admin_flag[log_errors]" = true;
      "php_admin_value[max_execution_time]" = 240;
      "php_admin_value[max_input_vars]" = 1500;
      "catch_workers_output" = true;
    };
    phpEnv."PATH" = lib.makeBinPath [ pkgs.php ];
  };

  systemd.services.typo3-symlink = {
    wantedBy = [ "multi-user.target" ];
    # before = [ "nginx.service" ];
    description = "Create TYPO3 Symlinks in ${dataDir}";
    serviceConfig = {
      ExecStart = pkgs.writeShellScript "typo3-symlinks" ''
        rm -f typo3 typo3_src index.php
        ln -s "${typo-src}" "typo3_src"
        ln -sf "typo3_src/typo3" "./typo3"
        ln -sf "typo3_src/index.php" "./index.php"
      '';
      WorkingDirectory = dataDir;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts.${domain} = {
      root = dataDir;
      locations = {

        "~ \.php$" = {
          extraConfig = ''
            fastcgi_split_path_info ^(.+\.php)(/.+)$;
            fastcgi_pass unix:${config.services.phpfpm.pools.${app}.socket};
            include ${pkgs.nginx}/conf/fastcgi_params;
            include ${pkgs.nginx}/conf/fastcgi.conf;
          '';
        };

        "/".extraConfig = ''
          try_files $uri /index.php$is_args$args;
        '';
      };
    };
  };

  users.users.${app} = {
    isSystemUser = true;
    createHome = true;
    home = dataDir;
    group = app;
  };

  users.groups.${app} = {};
}
