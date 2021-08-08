{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    breeze-gtk
    chromium
    ddrescue
    fdupes
    ffmpeg
    filelight
    firefox
    geeqie
    gwenview
    hexchat
    kate
    kde-gtk-config
    keepassx2
    mpv
    nix-tree
    okular
    qmmp
    tigervnc
    vlc
    wine
    youtubeDL
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl = {
    driSupport32Bit = true; # for wine
    extraPackages = with pkgs; [ intel-media-driver vaapiIntel ];
  };

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
