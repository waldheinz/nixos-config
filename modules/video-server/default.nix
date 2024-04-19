{ pkgs, ... }:

let

    video-server = pkgs.python3Packages.buildPythonPackage {
        name = "mdi-video-server";
        src = ./src;
        propagatedBuildInputs = with pkgs.python3Packages; [ xdg-base-dirs ];
    };

in {
  systemd.services.video-server = {
    description = "MDI Video Server";
    wantedBy = [ "multi-user.target" ];
    environment.XDG_DATA_DIRS = "/home/trem/Videos/streams";
    path = [ pkgs.ffmpeg ];
    serviceConfig = {
      StandardOutput = "syslog";
      ExecStart = "${video-server}/bin/video-server.py";
    };
  };
}
