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
          version = "4.0.0";
          sha256 = "sha256:1kqbdikz98vy9z14ms1gqw9zws98phrhjdf0is3dwpbigwlcmmdi";
        }

        {
          publisher = "timonwong";
          name = "shellcheck";
          version = "0.9.0";
          sha256 = "129495np1kgy3d35c7lz6g43hgv9jpkicbj0nrillcb56gs74h8c";
        }

        {
          publisher = "ms-vscode";
          name = "vscode-typescript-tslint-plugin";
          version = "1.2.3";
          sha256 = "0dv80n120sfs77rxfm8i0w1i0hrh79w5f39rvmhc6xi9ik548vgg";
        }

        {
          publisher = "vigoo";
          name = "stylish-haskell";
          version = "0.0.10";
          sha256 = "1zkvcan7zmgkg3cbzw6qfrs3772i0dwhnywx1cgwhy39g1l62r0q";
        }

        {
          publisher = "justusadam";
          name = "language-haskell";
          version = "3.0.3";
          sha256 = "1sg4g8h1gww4y67zix5f33v2gf121k2fcm6l1m7lygpkn40a8dsj";
        }

        {
          publisher = "zxh404";
          name = "vscode-proto3";
          version = "0.4.2";
          sha256 = "sha256:05da62iahnnjxkgdav14c1gn90lkgyk9gc5rardsqijx2x6dgjn0";
        }
      ];
    };
in {
  environment.systemPackages = with pkgs; [
    cargo
    gdb
    git
    git-lfs
    haskellPackages.stylish-haskell
    my-vscode
    nodePackages.typescript
    shellcheck
    sqlitebrowser
    stack
  ];
}
