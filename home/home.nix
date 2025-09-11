{ config, pkgs, inputs, ... }:

{
  imports = [
    ./ghostty.nix
    ./zsh.nix
    ./git.nix
    ./direnv.nix
    ./fastfetch/fastfetch.nix
    ./emacs/emacs.nix
  ];

  home.packages = with pkgs; [
    obsidian
  ];  

  programs.vscode.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}
