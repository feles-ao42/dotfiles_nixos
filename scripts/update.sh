sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --list
sudo nix-channel --update
sudo nixos-rebuild switch
