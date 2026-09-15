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
      plugins = [
	"direnv"
      ];
    };

    shellAliases = {
      ll = "ls -l";
      ls = "ls -a";
      ".." = "cd ..";
      nixswitch = "nh os switch /home/booky/.dotfiles ";
      hm = "home-manager";
      hms = "home-manager switch -- flake ~/.dotfiles#";
      startMruVPN = "systemctl start openvpn-mruVPN.service";
      stopMruVPN = "systemctl stop openvpn-officeVPN.service";
      pyenv = "source .venv/bin/activate";
    };

    initContent = ''
      if [[ -o interactive ]]; then
        fastfetch
      fi
    '';
  
  };

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
}
