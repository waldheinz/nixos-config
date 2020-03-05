{ pkgs ? import <nixpkgs> { } }:
let
    nodePackages = import ./node-packages.nix {
        inherit pkgs;
        nodejs = pkgs.nodejs;
        inherit (pkgs.stdenv.hostPlatform) system;
    };

    hb = nodePackages."homebridge-git+https://github.com/nfarina/homebridge.git#v0.4.46";

    runtimeEnv = pkgs.buildEnv {
        name = "homebridge-runtime";
        paths = [
            nodePackages."homebridge-git+https://github.com/nfarina/homebridge.git#v0.4.46"
            nodePackages."homebridge-homematic-git+https://github.com/thkl/homebridge-homematic.git#0.0.219"
            nodePackages."homebridge-mqttthing-git+https://github.com/arachnetech/homebridge-mqttthing.git#ver_1.0.50"
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