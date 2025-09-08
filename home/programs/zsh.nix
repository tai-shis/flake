{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      ".." = "cd ..";
      nixswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles#";
      hm = "home-manager";
      hms = "home-manager switch -- flake ~/.dotfiles#";
    };
  };

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
}
