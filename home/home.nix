{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs/ghostty.nix
    ./programs/zsh.nix
    ./programs/git.nix
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    gh
  ];  

  home.stateVersion = "25.05";
}
