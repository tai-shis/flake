{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    btop
    bun
    wl-clipboard-x11
  ];
}
