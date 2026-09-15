{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix

    ../../modules/nixos/system
    ../../modules/nixos/security
    ../../modules/nixos/hardware/fingerprint.nix
    ../../modules/nixos/hardware/backlight.nix
    ../../modules/nixos/apps
    ../../modules/nixos/desktop
  ];

  networking.hostName = "dragonair";

  system.stateVersion = "26.05";
}
