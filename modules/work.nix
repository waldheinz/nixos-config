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

        {
          publisher = "vigoo";
          name = "stylish-haskell";
          version = "0.0.10";
          sha256 = "1zkvcan7zmgkg3cbzw6qfrs3772i0dwhnywx1cgwhy39g1l62r0q";
        }

        {
          publisher = "justusadam";
          name = "language-haskell";
          version = "2.6.0";
          sha256 = "1891pg4x5qkh151pylvn93c4plqw6vgasa4g40jbma5xzq8pygr4";
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
