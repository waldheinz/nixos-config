{ config, pkgs, ... }:

{
  services.grafana = {
    enable = true;
    addr = "[::]";
    domain = "blackbox.lan.waldheinz.de";
  };
}
