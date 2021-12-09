{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      blackbox = nixpkgs.lib.nixosSystem { system = "x86_64-linux"; modules = [ ./machines/blackbox ]; };
      gehirnfasching = nixpkgs.lib.nixosSystem { system = "x86_64-linux"; modules = [ ./machines/gehirnfasching ]; };
      homepi = nixpkgs.lib.nixosSystem { system = "aarch64-linux"; modules = [ ./machines/homepi ]; };
      squirrel = nixpkgs.lib.nixosSystem { system = "x86_64-linux"; modules = [ ./machines/squirrel ]; };
    };
  };
}
