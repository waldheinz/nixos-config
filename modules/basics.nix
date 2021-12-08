{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    htop
  ];

  services = {
    openssh.enable = true;  # we always want to be able to ssh in
    fstrim.enable = true;  # it's easy to miss and does not hurt when not really needed
  };

  nix = {
    package = pkgs.nixFlakes;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    trustedUsers = [ "root" "@wheel" ];

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  nix.optimise.automatic = true;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super:
        (import ../pkgs/default.nix { pkgs = super; })
      )
    ];
  };
}
