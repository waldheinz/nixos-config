{ config, pkgs, ... }:

{
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "de";
    defaultLocale = "de_DE.UTF-8";
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.en
  ];
}
