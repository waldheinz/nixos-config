{ config, pkgs, ... }:

{
  i18n = { defaultLocale = "de_DE.UTF-8"; };
  console = { font = "lat9w-16"; keyMap = "de"; };
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.en
  ];
}
