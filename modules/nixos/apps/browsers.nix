{ inputs, system, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
  ];
}
