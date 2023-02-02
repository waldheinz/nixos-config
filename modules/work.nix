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
          version = "7.0.6";
          sha256 = "sha256-Qs6aiX9VqZNNKT/UebKRdBO7hCR2urBDOOyx2wA/trQ=";
        }

        {
          publisher = "timonwong";
          name = "shellcheck";
          version = "0.14.1";
          sha256 = "sha256-X3ihMxANcqNLWl9oTZjCgwRt1uBsSN2BmC2D4dPRFLE=";
        }

        {
          publisher = "ms-vscode";
          name = "vscode-typescript-tslint-plugin";
          version = "1.3.3";
          sha256 = "sha256-ISELYPs/b22TAXWldmm0omCmBp5NfhiwRz3d0iu7WvY=";
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
          version = "3.4.0";
          sha256 = "sha256-/pidWbyT+hgH7GslVAYK1u5RJmMSvMqj6nKq/mWpZyk=";
        }

        {
          publisher = "zxh404";
          name = "vscode-proto3";
          version = "0.5.4";
          sha256 = "sha256-S89qRRlfiTsJ+fJuwdNkZywe6mei48KxIEWbGWChriE=";
        }

        {
          publisher = "ms-python";
          name = "python";
          version = "2021.5.842923320";
          sha256 = "sha256-WYio9Mc0SeJIQNlO8ua059WgwLBrvNTOwy3ZklJVeaA=";
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
    jq
    # my-vscode
    vscode-fhs
    nodePackages.typescript
    python3Packages.pycodestyle
    python3Packages.python
    shellcheck
    sqlitebrowser
    stack
    weston
  ];

  nix.settings = {
    trusted-public-keys = [ "nix-cache.lan.meetwise.de:VJS4V7/IkUclm1cBVo/jyZ1Pu0ADBraMU/1dPDrDAhY=" ];
    substituters = [ "http://nix-cache.lan.meetwise.de" ];
  };
}
