{ config, pkgs, ... }:

{ fonts = {
    enableFontDir = true;
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
