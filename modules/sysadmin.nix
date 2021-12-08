{ config, pkgs, ... }:
let
    my-nvim = with pkgs; neovim.override {
      configure = {
        customRC = lib.fileContents ./sysadmin-nvim-init.vim;
        packages.myVimPackage = with vimPlugins; {
          start = [
            ctrlp-vim
            nerdtree
            tsuquyomi
            typescript-vim
            vim-airline
            vim-airline-themes
            vim-colors-solarized
            vim-gitgutter
            vimproc-vim
          ];
          opt = [ ];
        };
      };
    };
in {
  environment.systemPackages = with pkgs; [
    binutils
    file
    iftop
    iotop
    lsof
    mc
    mtr
    my-nvim
    openssl
    pciutils
    psmisc
    tcpdump
    unrar
    unzip
    wget
    which
    wireshark
  ];

  programs.wireshark = {
    enable = true;
  };
}
