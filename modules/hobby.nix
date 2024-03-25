{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    esptool
    freecad
    handbrake
    # minecraft
    openscad
    prusa-slicer
    transmission-remote-gtk
    gimp
  ];
}
