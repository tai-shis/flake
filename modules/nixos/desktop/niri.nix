{ pkgs, lib, ... }:

{
  programs.niri.enable = true;
  services.displayManager.defaultSession = lib.mkForce "niri";

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    fuzzel
    swaylock
  ];
}
