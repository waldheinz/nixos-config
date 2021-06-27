{ config, pkgs, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;
    whitelist = {
      hannes = "3cea33a7-8cd1-4a65-aa56-99ca3f9eab38";
      hannes2 = "f878657f-1ddb-4eca-96ff-29d9f5beb2c2";  # Piet356
      noschxl = "a8b58857-a15c-46ad-a017-54db27bc3652";
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
