{
  outputs = { self, nixpkgs }: {
    nixosConfigurations.homepi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [ ./machines/homepi ];
    };
  };
}
