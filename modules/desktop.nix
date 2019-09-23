{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    hexchat
    mpv
  ];
}
