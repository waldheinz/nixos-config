{ config, pkgs, ... }:

let

in {
    systemd.services.send-streams = {
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        description = "Send Multicast Streams";
        serviceConfig = {
            KillSignal = "SIGINT";
            Restart = "always";
            RestartSec = 30;
            User = "trem";
            WorkingDirectory = "/home/trem/Krimskrams/Musikvideos";
            ExecStart = pkgs.writeShellScript "send-mc-streams" ''
                counter=0

                for file in *
                do
                    dst="udp://239.13.42.$counter:4567"
                    echo "$file streaming to $dst"

                    ${pkgs.ffmpeg}/bin/ffmpeg \
                        -loglevel panic \
                        -stream_loop -1 \
                        -re -i "$file" \
                        -c:v copy -c:a copy \
                        -f mpegts "$dst" &

                    counter=$((counter + 1))
                done

                wait
            '';
        };
    };
}
