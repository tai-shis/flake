{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "af-magic";	
    };

    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      ".." = "cd ..";
      nixswitch = "sudo nixos-rebuild switch --flake ~/.dotfiles#truffle";
      hm = "home-manager";
      hms = "home-manager switch -- flake ~/.dotfiles#";
      startMruVPN = "systemctl start openvpn-mruVPN.service";
      stopMruVPN = "systemctl stop openvpn-officeVPN.service"; 
   };
  };

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
}
