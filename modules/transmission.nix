{ config, pkgs, ... }:

{
  services.transmission = {
    enable = true;
    group = "torrents";
  };
}
