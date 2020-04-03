{ config, pkgs, ... }:

{

    services.unifi = {
        enable = true;
        unifiPackage = pkgs.unifi;
    };

    nixpkgs.config.permittedInsecurePackages = [ "openssl-1.0.2u" ];
}
