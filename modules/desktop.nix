{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    digikam
    filelight
    hexchat
    mpv
  ];
}
