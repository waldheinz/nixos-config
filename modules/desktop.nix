{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    akonadi
    breeze-gtk
    chromium
    digikam
    dropbox
    esptool
    fdupes
    ffmpeg
    filelight
    firefox
    freecad
    geeqie
    hexchat
    kde-gtk-config
    kdeApplications.kmail-account-wizard
    keepassx2
    kmail
    minecraft
    mpv
    okular
    prusa-slicer
    qmmp
    transmission-remote-gtk
    vlc
    youtubeDL
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
