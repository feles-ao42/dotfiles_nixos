{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
	<nixos-hardware/lenovo/thinkpad/x1/10th-gen>	
    ];

  environment.systemPackages = with pkgs; [
    #hardware conf
    fprintd
  ];

  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };

}

