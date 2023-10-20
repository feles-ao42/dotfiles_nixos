{ config, pkgs, ... }:


{
  programs.zsh = {
    enable = true;
    shellAliases = {
      feles = "neofetch";
      ll = "ls -l";
      la = "ls -al";
      update = "sudo nixos-rebuild switch";
    };
  };
}
