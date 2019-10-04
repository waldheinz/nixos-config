{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    breeze-gtk
    chromium
    digikam
    fdupes
    ffmpeg
    filelight
    firefox
    geeqie
    hexchat
    kde-gtk-config
    keepassx2
    mpv
    transmission-remote-gtk
    vlc
  ];
}
