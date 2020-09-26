#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix
set -euo pipefail

node2nix -12 \
     --input node-packages.json \
     --output node-packages-generated.nix \
     --composition node-packages.nix
