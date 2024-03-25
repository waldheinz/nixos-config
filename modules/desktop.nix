{ config, pkgs, ... }:

let
  my-python-packages = ps: with ps; [
    imageio
    numpy
    scipy
  ];
in {
  environment.systemPackages = with pkgs; [
    (python3.withPackages my-python-packages)
    breeze-gtk
    chromium
    ddrescue
    fdupes
    ffmpeg
    filelight
    firefox
    geeqie
    gimp
    gwenview
    hexchat
    kate
    kde-gtk-config
    keepassxc
    kmscube
    mpv
    nix-tree
    okular
    qmmp
    tigervnc
    vlc
    vulkan-tools
    wine
    yt-dlp
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
    # "net.ipv6.conf.default.use_tempaddr" = "2";
  };

}
