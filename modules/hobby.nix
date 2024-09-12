{ pkgs, ... }:

let
    grav1synth = with pkgs; rustPlatform.buildRustPackage {
        name = "grav1synth";

        src = fetchFromGitHub {
            owner = "rust-av";
            repo = "grav1synth";
            rev = "b877ba162b158b1574897ee066000c99507e414b";
            sha256 = "sha256-W9wk5lH1F/5rwvVklARv3MJUl2am8ozQbvdXQila3/g=";
        };

        cargoSha256 = "sha256-X4gv5qOKKfSLdZbhd4+M8Yo55QrqbzYcciaquPH4Fi8=";
        LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";

        buildInputs = [ pkgs.ffmpeg_7 ];
        nativeBuildInputs = [ pkgs.pkg-config ];
        doCheck = false;
        preBuild = with pkgs; ''
            # From: https://github.com/NixOS/nixpkgs/blob/1fab95f5190d087e66a3502481e34e15d62090aa/pkgs/applications/networking/browsers/firefox/common.nix#L247-L253
            # Set C flags for Rust's bindgen program. Unlike ordinary C
            # compilation, bindgen does not invoke $CC directly. Instead it
            # uses LLVM's libclang. To make sure all necessary flags are
            # included we need to look in a few places.
            export BINDGEN_EXTRA_CLANG_ARGS="$(< ${stdenv.cc}/nix-support/libc-crt1-cflags) \
            $(< ${stdenv.cc}/nix-support/libc-cflags) \
            $(< ${stdenv.cc}/nix-support/cc-cflags) \
            $(< ${stdenv.cc}/nix-support/libcxx-cxxflags) \
            ${lib.optionalString stdenv.cc.isClang "-idirafter ${stdenv.cc.cc}/lib/clang/${lib.getVersion stdenv.cc.cc}/include"} \
            ${lib.optionalString stdenv.cc.isGNU "-isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc} -isystem ${stdenv.cc.cc}/include/c++/${lib.getVersion stdenv.cc.cc}/${stdenv.hostPlatform.config} -idirafter ${stdenv.cc.cc}/lib/gcc/${stdenv.hostPlatform.config}/${lib.getVersion stdenv.cc.cc}/include"} \
            "
        '';

    };
in {
  environment.systemPackages = with pkgs; [
    grav1synth
    esptool
    freecad
    handbrake
    # minecraft
    openscad
    prusa-slicer
    transmission-remote-gtk
    gimp
  ];
}
