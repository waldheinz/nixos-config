{ stdenv, fetchFromGitHub, makeWrapper
, smartmontools, gawk }:

stdenv.mkDerivation rec {
    name = "node-exporter-textfile-collector-scripts";

    src = fetchFromGitHub {
        owner = "prometheus-community";
        repo = name;
        rev = "8eeeffb362c31af4427b21a84e2ef6cbdddfd0c3";
        hash = "sha256-baQRi0aLFX+BEO0vfHWBEJR59gbReihCu5k9ZD602WY=";
    };

    nativeBuildInputs = [ makeWrapper ];

    installPhase = ''
        mkdir -p $out/bin
        cp * $out/bin/

        rm $out/bin/CODE_OF_CONDUCT.md
        rm $out/bin/LICENSE
        rm $out/bin/MAINTAINERS.md
        rm $out/bin/README.md
        rm $out/bin/SECURITY.md

        substituteInPlace $out/bin/smartmon.sh \
            --replace /usr/sbin/smartctl ${smartmontools}/bin/smartctl
        wrapProgram $out/bin/smartmon.sh \
            --suffix PATH : ${gawk}/bin
    '';
}
