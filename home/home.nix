{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs/ghostty.nix
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/fastfetch/fastfetch.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];  

  programs.vscode.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}
