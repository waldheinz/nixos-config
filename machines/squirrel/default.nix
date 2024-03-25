{ config, pkgs, ... }:

{
  imports = [
    ../../modules/basics.nix
    ../../modules/desktop.nix
    ../../modules/direnv.nix
    ../../modules/fonts.nix
    ../../modules/hobby.nix
    ../../modules/i18n.nix
    # ../../modules/like-home.nix
    ../../modules/razer.nix
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
  nix.settings = {
    max-jobs = 3;
    cores = 8;
  };

#   nix.distributedBuilds = false;
#   nix.buildMachines = [
#     {
#         hostName = "fox.lan.meetwise.de";
#         sshUser = "trem";
#         system = "x86_64-linux";
#         maxJobs = 6;
#         speedFactor = 3;
#         publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUZIOXNLeU0rVEhudHB2aWhJclRBeHQvMnBISW9NaGF5VUtMMythTzFHWmUgcm9vdEBuaXhvcwo=";
#         supportedFeatures = [
#             "kvm" "nixos-test"
#             "big-parallel" "benchmark"
#         ];
    # }
#   ];
  system.stateVersion = "19.03";
}
