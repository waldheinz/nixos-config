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
    # just more sensible
    dbus.socketActivated = true;
  };

  nixpkgs.config.allowUnfree = true;
}
