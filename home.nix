{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "feles";
  home.homeDirectory = "/home/feles";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
  ];

  home.packages = (with pkgs; [
    curl
    git
    hub
    neovim
    tmux
    vim

    # basic command
    tree
    wget
    gnupg
    #pinentry_mac
    #pinentry
    htop
    direnv
    zsh
    xz
    mtr
    hugo
    zlib
    #darwin.iproute2mac

    # advanced command
    iperf3

    # toy command
    neofetch
    
    #langages
    asdf-vm
    python39

    #applications
    adobe-reader
    firefox
    jetbrains.pycharm-professional
    jetbrains.webstorm
    jetbrains.rider
    vlc

  ]);
}
