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
    bind # provides `dig`
    binutils
    cryptsetup
    ddrescue
    dmidecode
    dstat
    file
    git
    gptfdisk
    htop
    iftop
    iotop
    linuxPackages.perf
    lshw
    lsof
    mosh
    mtr
    my-nvim
    nftables
    numactl
    openssl
    pciutils
    psmisc
    ripgrep
    tcpdump
    tmux
    tree
    unzip
    wget
    which
    wireshark
  ];
}
