{ config, pkgs, inputs, ... }:

{
  imports = [
    ./terminal/default.nix
    ./git.nix
    ./direnv.nix
    ./fastfetch/fastfetch.nix
    ./emacs/emacs.nix
  ];

  home.packages = with pkgs; [
    obsidian
    ghc
  ];  

  programs.vscode.enable = true;

  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}
