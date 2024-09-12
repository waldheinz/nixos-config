{ config, pkgs, ... }:

{ fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts
      hack-font
      inconsolata
      noto-fonts
      symbola
      ubuntu_font_family
      unifont
    ];
  };
}
