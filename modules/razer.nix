{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.razergenie ];

  hardware.openrazer = {
    # enable = true;
    devicesOffOnScreensaver = false;
  };
}
