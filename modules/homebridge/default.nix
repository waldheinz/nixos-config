{ pkgs ? import <nixpkgs> { } }:
let
    nodePackages = import ./node-packages.nix {
        inherit pkgs;
        inherit (pkgs.stdenv.hostPlatform) system;
    };

    hb = nodePackages."homebridge";

    runtimeEnv = pkgs.buildEnv {
        name = "homebridge-runtime";
        paths = [
            hb
            nodePackages."homebridge-homematic"
            nodePackages."homebridge-mqttthing"
        ];
    };

in pkgs.stdenv.mkDerivation {
    name = "homebridge-with-plugins";
    dontBuild = true;
    unpackPhase = "true";
    configurePhase = "true";
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
        mkdir -p $out/bin
        cat >$out/bin/homebridge <<EOF
        #!${pkgs.runtimeShell}
        exec ${hb}/bin/homebridge "\$@"
        EOF
    '';

    postFixup = ''
        chmod +x $out/bin/homebridge
        wrapProgram $out/bin/homebridge \
            --set NODE_PATH "${runtimeEnv}/lib/node_modules"
    '';
}
