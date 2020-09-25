{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    minecraft
    prusa-slicer
    transmission-remote-gtk
    handbrake
    esptool
    freecad
  ];
}