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

  services.printing = {
    enable = true;
    browsing = true;
  };

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "1048576";  # vscode likes this, others probably as well
    "net.ipv6.conf.all.use_tempaddr" = "2";
    "net.ipv6.conf.default.use_tempaddr" = "2";
  };

}
