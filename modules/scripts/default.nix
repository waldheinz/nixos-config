{ config, pkgs, lib, ... }:

let
    ffmpeg = pkgs.ffmpeg-full.override {
        nonfreeLicensing = true;
        fdkaacExtlib = true;
        fdk_aac = pkgs.fdk_aac;
    };

    flowpy = pkgs.python3.withPackages (ps: with ps; [
        numpy
        (opencv4.override (old: { enableFfmpeg = true; enableGtk2 = true; }))
    ]);

    scripts = pkgs.stdenv.mkDerivation {
        name = "scripts";
        src = ./src;
        buildInputs = [ flowpy ];
        nativeBuildInputs = [ pkgs.makeWrapper ];

        installPhase = ''
            mkdir -p $out/bin
            cp *.sh $out/bin
            cp *.py $out/bin

            wrapProgram $out/bin/convert-1080p-hdr.sh \
                --prefix PATH : ${ffmpeg}/bin
        '';
    };

in {
    environment.systemPackages = [ scripts ];
}
