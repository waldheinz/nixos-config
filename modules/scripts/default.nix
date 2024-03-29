{ config, pkgs, lib, ... }:

let
    ffmpeg = pkgs.ffmpeg-full.override {
        nonfreeLicensing = true;
        fdkaacExtlib = true;
        fdk_aac = pkgs.fdk_aac;
    };

    scripts = pkgs.stdenv.mkDerivation {
        name = "scripts";
        src = ./src;
        nativeBuildInputs = [ pkgs.makeWrapper ];

        installPhase = ''
            mkdir -p $out/bin
            cp *.sh $out/bin

            wrapProgram $out/bin/convert-1080p-hdr.sh \
                --prefix PATH : ${ffmpeg}/bin
        '';
    };

in {
    environment.systemPackages = [ scripts ];
}
