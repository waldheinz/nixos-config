{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false; 

  users.users.trem = {
    description = "Matthias Treydte";
    isNormalUser = true;
    extraGroups = [ 
      "audio" "video"
      "libvirtd"
      "networkmanager" 
      "sway"
      "systemd-journal"
      "vboxusers" 
      "wheel" 
    ];
    shell = pkgs.zsh;
    uid = 1000;
    openssh.authorizedKeys.keyFiles = [ ../keys/authorized-trem.pub ];
  };
}
