{ config, pkgs, ... }:

{
  services.avahi = {
    enable = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  services.samba = {
    enable = true;
    enableWinbindd = false;
    package = pkgs.sambaFull;

    extraConfig = ''
      fruit:delete_empty_adfiles = yes
      fruit:metadata = stream
      fruit:model = MacSamba
      fruit:posix_rename = yes
      fruit:veto_appledouble = no
      fruit:wipe_intentionally_left_blank_rfork = yes
      map to guest = bad user
      mdns name = mdns
      min protocol = SMB2
      vfs objects = catia fruit streams_xattr
    '';

    shares = {
      "Time Machine" = {
        "browseable" = "yes";
        "force user" = "trem";
        "fruit:time machine" = "yes";
        "path" = "/mnt/time-machine";
        "public" = "no";
        "valid users" = "trem";
        "vfs objects" = "catia fruit streams_xattr";
        "writeable" = "yes";
      };
    };
  };
}
