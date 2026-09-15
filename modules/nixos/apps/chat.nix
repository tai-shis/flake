{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    vesktop
  ];
}
