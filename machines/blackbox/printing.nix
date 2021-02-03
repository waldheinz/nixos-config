{ config, pkgs, ... }:

{
  services.printing = {
    enable = true;
    browsing = true;
    defaultShared = true;
    drivers = [ pkgs.hplip ];
    extraConf = ''
        ServerAlias *
        DefaultEncryption Never

        <Location />
            Allow all
        </Location>

        <Location /admin>
            Allow all
        </Location>

        <Location /admin/conf>
            Allow all
        </Location>
    '';
    listenAddresses = [ "*:631" ];
  };

  services.avahi.extraServiceFiles = {
    airprint = builtins.readFile ./printing-airprint.xml;
  };
}
