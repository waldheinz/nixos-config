exec nix-shell -p mosquitto --run "mosquitto_pub -t \"tasmotas/cmnd/$1\" -m \"$2\""
