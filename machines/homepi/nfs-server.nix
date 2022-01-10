{ ... }:

{
  networking.firewall.allowedTCPPorts = [ 2049 ];

  services.nfs.server = {
    enable = true;
    exports = ''
      /home/trem *(rw,no_subtree_check)
      /mnt/incoming *(rw,no_subtree_check)
      /mnt/media *(rw,no_subtree_check)
    '';
  };
}
