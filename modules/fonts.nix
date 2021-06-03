{ config, pkgs, ... }:

{ fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
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
