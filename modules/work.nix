{ config, pkgs, ... }:

let
    my-vscode = pkgs.vscode-with-extensions.override {
      vscodeExtensions = with pkgs.vscode-extensions; [
        bbenoist.Nix
        ms-vscode.cpptools
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          publisher = "waderyan";
          name = "gitblame";
          version = "3.0.1";
          sha256 = "1h68fzm9glv7gqwbi15sk6iw45kp9r08wrv2vd6lwi45srriwgjp";
        }

        {
          publisher = "timonwong";
          name = "shellcheck";
          version = "0.8.1";
          sha256 = "0zg7ihwkxg0da0wvqcy9vqp6pyjignilsg9cldp5pp9s0in561cw";
        }

        {
          publisher = "ms-vscode";
          name = "vscode-typescript-tslint-plugin";
          version = "1.2.2";
          sha256 = "1n2yv37ljaadp84iipv7czzs32dbs4q2vmb98l3z0aan5w2g8x3z";
        }
      ];
    };

    my-nvim = with pkgs; neovim.override {
      configure = {
        customRC = lib.fileContents ./work-nvim-init.vim;
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
    git
    git-lfs
    my-nvim
    my-vscode
    shellcheck
  ];
}