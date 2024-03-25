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
    btop
    file
    gparted
    iftop
    iotop
    lsof
    lz4
    mc
    mtr
    my-nvim
    nmap
    openssl
    pciutils
    psmisc
    pv
    sshfs-fuse
    tcpdump
    tmux
    unrar
    unzip
    wget
    which
    wireshark
  ];

  programs.wireshark = {
    enable = true;
  };

  services.locate.enable = true;
}
