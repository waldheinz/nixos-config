{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    htop
    mc
    termite.terminfo
    tmux
    unrar
    vim_configurable
    yadm
  ];

  services = {
    # we always want to be able to ssh in
    openssh.enable = true;
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
  nixpkgs.config.allowUnfree = true;
}
