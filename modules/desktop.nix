{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chromium
    digikam
    filelight
    firefox
    hexchat
    mpv
  ];
}
