{ pkgs ? import <nixpkgs> { } }:

{
    deconz = pkgs.qt5.callPackage ./deconz { };
    node-exporter-textfile-collector-scripts = pkgs.callPackage ./node-exporter-textfile-collector-scripts { };
}
