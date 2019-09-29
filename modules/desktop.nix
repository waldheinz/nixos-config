{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    breeze-gtk
    chromium
    digikam
    ffmpeg
    filelight
    firefox
    hexchat
    kde-gtk-config
    mpv
    transmission-remote-gtk
    vlc
  ];
}
