{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  users.groups.torrents = {
    gid = 1000;
  };

  users.users.trem = {
    description = "Matthias Treydte";
    isNormalUser = true;
    extraGroups = [
      "audio" "video"
      "dialout"
      "disk"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "sway"
      "systemd-journal"
      "torrents"
      "vboxusers"
      "wheel"
    ];
    shell = pkgs.zsh;
    uid = 1000;
    openssh.authorizedKeys.keyFiles = [ ../keys/authorized-trem.pub ];
  };
}
