# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	<nixos-hardware/lenovo/thinkpad/x1/10th-gen>	
	./hardware-configuration.nix
	<home-manager/nixos>
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_lastest;


  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

 i18n.inputMethod = {
     enabled = "fcitx5";
     fcitx5.addons = with pkgs; [
         fcitx5-mozc
         fcitx5-gtk
     ];
 };

 fonts = {
   fonts = with pkgs; [
     noto-fonts-cjk-serif
     noto-fonts-cjk-sans
     noto-fonts-emoji
     nerdfonts
   ];
   fontDir.enable = true;
   fontconfig = {
     defaultFonts = {
       serif = ["Noto Serif CJK JP" "Noto Color Emoji"];
       sansSerif = ["Noto Sans CJK JP" "Noto Color Emoji"];
       monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
       emoji = ["Noto Color Emoji"];
     };
   };
 };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.feles = {
    isNormalUser = true;
    description = "feles";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers"];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #firefox
    #brave
    thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	
	# for config
	fprintd
	
	# base command
	wget
	vim
	tilix
	gcc
	gnumake
	automake
	cmake
	gdb
	git
	zsh
	screen

	# application's
	burpsuite
	vscode
	wireshark	
	brave
	zoom-us
	slack
	discord
	jupyter
	
	# personal command
	docker
	docker-compose
	fzf
	gnupg
	htop
	direnv
  ];

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;


virtualisation.docker.enable = true;

programs.zsh.enable = true;

services.fprintd.enable = true;

services.fprintd.tod.enable = true;

services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 443 80 8080 8554];
  #networking.firewall.allowedUDPPorts = [ 443 80 8080 8554];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?


  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
  };

  hardware.ipu6 = {
    enable = true;
    platform = "ipu6ep";
  };

  # Home Manager
  home-manager.users.feles = { config, pkgs, ... }: {
    imports = [
      /home/feles/dotfiles_nixos/home.nix
      #/home/feles/.config/nixpkgs/custom.nix
    ];
    home.stateVersion = "23.05";
    home.homeDirectory = "/home/feles";
  };

}
