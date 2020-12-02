{ config, pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    whitelist = {
      waldheinz = "8cab3f52-270f-4c0d-a9fe-94c32d861201";
    };

    serverProperties = {
      server-port = 25565;
      max-players = 5;
      white-list = true;
      motd = "Heute was Grosses!";
      view-distance = 32;
    };
  };
}
