{ ... }:

{

  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/incoming *(rw,no_subtree_check)
      /home/trem *(rw,no_subtree_check)
    '';
  };
}
