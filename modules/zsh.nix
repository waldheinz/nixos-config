{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [ "git" "sudo" ];
    theme = "robbyrussell";
  };
}

