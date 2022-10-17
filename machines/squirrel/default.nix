{ config, pkgs, ... }:

{
  imports = [
    ../../modules/basics.nix
    ../../modules/desktop.nix
    ../../modules/direnv.nix
    ../../modules/fonts.nix
    ../../modules/hobby.nix
    ../../modules/i18n.nix
    ../../modules/like-home.nix
    ../../modules/razer.nix
    ../../modules/scripts
    ../../modules/syncthing.nix
    ../../modules/sysadmin.nix
    ../../modules/users.nix
    ../../modules/work.nix
    ../../modules/x11.nix
    ../../modules/zsh.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./node-exporter.nix
    ./send-streams.nix
  ];

  environment.systemPackages = with pkgs; [
    transmission-qt
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.loader.systemd-boot.memtest86.enable = true;

  boot.kernelParams = [ "pcie_aspm=off" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "squirrel"; # Define your hostname.
  networking.hostId = "33f63802";

  system.stateVersion = "19.03";
}
